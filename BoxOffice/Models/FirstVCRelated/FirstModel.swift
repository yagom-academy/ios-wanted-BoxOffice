//
//  FirstModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class FirstModel: SceneActionReceiver {
    //input
    var didTapCalendarButton: (() -> ()) = { }
    var didReceiveSceneAction: (SceneAction) -> () = { action in }
    
    //output
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    var firstContentViewModel: FirstContentViewModel {
        return privateFirstContentViewModel
    }
    
    //properties
    private var privateFirstContentViewModel: FirstContentViewModel
    
    private var repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        
        let httpClient = HTTPClient()
        let contentVMrepository = Repository(httpClient: httpClient)
        self.privateFirstContentViewModel = FirstContentViewModel(repository: contentVMrepository)
        self.repository = repository
        bind()
    }
    
    func populateData() {
        print(#function)
        Task {
            privateFirstContentViewModel.turnOnIndicator?(())
            let parkBenchTimer = ParkBenchTimer()
            guard let entity = await requestAPI() else { return }
            privateFirstContentViewModel.didReceiveEntity(entity)
            parkBenchTimer.stop()
        }
    }
    
    private func bind() {
        privateFirstContentViewModel.propergateDidSelectItem = { [weak self] entity in
            guard let self = self else { return }
            
            let httpClient = HTTPClient()
            let repository = Repository(httpClient: httpClient)
            let secondModel = SecondModel(repository: repository)
            secondModel.previousSelectedMovieEntity = entity
            let context = SceneContext(dependency: secondModel)
            self.routeSubject?(.detail(.secondViewController(context: context)))
        }
        
        didTapCalendarButton = { [weak self] in
            guard let self = self else { return }
            
            let fourthModel = FourthModel()
            let context = SceneContext(dependency: fourthModel)
            self.routeSubject?(.detail(.fourthViewController(context: context)))
        }
        
        didReceiveSceneAction = { [weak self] action in
            guard let self else { return }
            guard let action = action as? FirstSceneAction else { return }
            switch action {
            case .refresh:
                break
            case .reloadWithSelectedDate(let dateString):
                self.populateDataWithSelectedDate(dateString: dateString)
                break
            }
        }
    }
    
    private func requestAPI() async -> KoficMovieEntity? {
        print(#function)
        do {
            //today check : 20221019 : 2022-10-19 08:37:18 +0000
            // TODO: 데이트피커 관련 뷰? 추가하고 해당 템프값 관련사항 수정
            let today = Date().addingTimeInterval(TimeInterval(-86400))
            let todayString = today.asString(.koficFormat)
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

extension FirstModel {
    func populateDataWithSelectedDate(dateString: String) {
        print(#function)
        Task {
            privateFirstContentViewModel.turnOnIndicator?(())
            guard let entity = await requestAPIWithSelectedDate(dateString: dateString) else { return }
            privateFirstContentViewModel.didReceiveEntity(entity)
        }
    }
    
    private func requestAPIWithSelectedDate(dateString: String) async -> KoficMovieEntity? {
        print(#function)
        do {
            print("dateString check : \(dateString)")
            let entity: KoficMovieEntity = try await repository.fetch(api: .kofic(.daily(date: dateString)))
            return entity
        } catch let error {
            handleError(error: error)
            return nil
        }
    }
}
