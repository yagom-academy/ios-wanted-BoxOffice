//
//  SecondModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class SecondModel: SceneActionReceiver {
    //input
    var previousSelectedMovieEntity: DailyBoxOfficeList = DailyBoxOfficeList()
    var didReceiveSceneAction: (SceneAction) -> () = { action in }
    //output
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    @MainThreadActor var turnOnIndicator: ( ((Void)) -> () )?
    @MainThreadActor var turnOffIndicator: ( ((Void)) -> () )?
    
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
            self.turnOnIndicator?(())
            print("secondModel populate Data")
            guard let entity = await requestAPI() else { return }
            privateSecondContentViewModel.didReceiveEntity(entity, previousSelectedMovieEntity)
            self.turnOffIndicator?(())
        }
    }
    
    private func bind() {
        privateSecondContentViewModel.propergateDidTapShareButton = { [weak self] info in
            guard let self = self else { return }
            let context = ActivityDependency(actionSet: [info])
            self.routeSubject?(.activityScene(context))
        }
        
        privateSecondContentViewModel.propergateDidTapReviewButton = { [weak self] in
            guard let self = self else { return }
            
            let thirdModel = ThirdModel()
            let context = SceneContext(dependency: thirdModel)
            self.routeSubject?(.detail(.thirdViewController(context: context)))
        }
    }
    
    private func requestAPI() async -> KoficMovieDetailEntity? {
        print("secondModel request api")
        print("movie cd check : \(self.previousSelectedMovieEntity.movieCd)")
        let movieCd = self.previousSelectedMovieEntity.movieCd
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
