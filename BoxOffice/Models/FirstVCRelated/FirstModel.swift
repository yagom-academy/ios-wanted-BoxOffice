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
        Task {
            await requestAPI()
        }
    }
    
    private func requestAPI() async {
        do {
            //today check : 20221019 : 2022-10-19 08:37:18 +0000
            let today = Date().asString(.koficFormat)
            print("today check : \(today) : \(Date())")
            let entity: KoficMovieEntity = try await repository.fetch(api: .kofic(.daily(date: today)))
        } catch let error {
            handleError(error: error)
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
