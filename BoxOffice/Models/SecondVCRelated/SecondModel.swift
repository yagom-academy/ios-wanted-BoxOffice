//
//  SecondModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class SecondModel: SceneActionReceiver {
    //input
    var previousSelectedMovieModel: FirstMovieCellModel = FirstMovieCellModel()
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
            // TODO: entity에 필요값 추가 <<- 1번째 화면에서 선택한 엔티티에서 값을 가져와야...
            privateSecondContentViewModel.didReceiveEntity(entity)
        }
    }
    
    private func bind() {
        
    }
    
    private func requestAPI() async -> KoficMovieDetailEntity? {
        print("secondModel request api")
        print("movie cd check : \(self.previousSelectedMovieModel.movieCd)")
        let movieCd = self.previousSelectedMovieModel.movieCd
        do {
            let entity: KoficMovieDetailEntity = try await repository.fetch(api: .kofic(.detailMovieInfo(movieCd: movieCd)))
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
