//
//  SecondModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class SecondModel: SceneActionReceiver {
    //input
    var movieCd: String = ""
    var didReceiveSceneAction: (SceneAction) -> () = { action in }
    //output
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    var secondContentViewModel: SecondContentViewModel {
        return privateSecondContentViewModel
    }
    
    //properties
    private var privateSecondContentViewModel: SecondContentViewModel
    
    private var repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.privateSecondContentViewModel = SecondContentViewModel()
        self.repository = repository
        bind()
    }
    
    func populateData() {
        
        Task {
            print("secondModel populate Data")
            guard let entity = await requestAPI() else { return }
            privateSecondContentViewModel.didReceiveEntity(entity)
        }
    }
    
    private func bind() {
        
    }
    
    private func requestAPI() async -> KoficMovieDetailEntity? {
        print("secondModel request api")
        print("movie cd check : \(self.movieCd)")
        do {
            let entity: KoficMovieDetailEntity = try await repository.fetch(api: .kofic(.detailMovieInfo(movieCd: self.movieCd)))
            print("secondModel entity check : \(entity)")
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
