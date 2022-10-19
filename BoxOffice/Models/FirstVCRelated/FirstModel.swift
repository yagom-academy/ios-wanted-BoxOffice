//
//  FirstModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class FirstModel {
    //input
    var didReceiveSceneAction: (SceneAction) -> () = { action in }
    
    //output
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    var firstContentViewModel: FirstContentViewModel {
        return privateFirstContentViewModel
    }
    
    //properties
    private var privateFirstContentViewModel: FirstContentViewModel
    
    private var repository: RepositoryProtocol
    
    // TODO: Repository
    init(repository: RepositoryProtocol) {
        self.privateFirstContentViewModel = FirstContentViewModel()
        self.repository = repository
        bind()
    }
    
    private func bind() {
        
    }
    
    func populateData() {
        print(#function)
        Task {
            guard let entity = await requestAPI() else { return }
            privateFirstContentViewModel.didReceiveEntity(entity)
        }
    }
    
    private func requestAPI() async -> KoficMovieEntity? {
        print(#function)
        do {
            //today check : 20221019 : 2022-10-19 08:37:18 +0000
            // TODO: 데이트피커 관련 뷰? 추가하고 해당 템프값 관련사항 수정
            let today = Date().addingTimeInterval(TimeInterval(-86400))
            let todayString = today.asString(.koficFormat)
            print("today check : \(today) : \(Date())")
            let entity: KoficMovieEntity = try await repository.fetch(api: .kofic(.daily(date: todayString)))
            return entity
        } catch let error {
            handleError(error: error)
            return nil
        }
    }
    
    private func handleError(error: Error) {
        
        let error = error as? HTTPError
        
        switch error {
        case .invalidURL, .errorDecodingData, .badResponse, .badURL, .iosDevloperIsStupid:
            let okAction = AlertActionDependency(title: "ok", style: .default, action: nil)
            let cancelAction = AlertActionDependency(title: "cancel", style: .cancel, action: nil)
            let alertDependency = AlertDependency(title: String(describing: error), message: "check network", preferredStyle: .alert, actionSet: [okAction, cancelAction])
            routeSubject?(.alert(.networkAlert(.normalErrorAlert(alertDependency))))
        case .none:
            break
        }
    }
}
