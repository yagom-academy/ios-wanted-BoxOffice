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
    
    //properties
    private var repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
        bind()
    }
    
    func populateData() {
        
    }
    
    private func bind() {
        
    }
    
    private func requestAPI() {
        
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
