//
//  FourthModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import Foundation

class FourthModel {
    //output
    @MainThreadActor var routeSubject: ( (SceneCategory) -> () )?
    
    var fourthContentViewModel: FourthContentViewModel {
        return privateFourthContentViewModel
    }
    
    //properties
    private var privateFourthContentViewModel: FourthContentViewModel
    
    init() {
        self.privateFourthContentViewModel = FourthContentViewModel()
        bind()
    }
    
    private func bind() {
        self.privateFourthContentViewModel.propergateNewDate = { [weak self] dateString in
            guard let self = self else { return }
            
            
            let context = SceneContext(dependency: FirstSceneAction.reloadWithSelectedDate(dateString: dateString))
            
            self.routeSubject?(.main(.firstViewControllerWithAction(context: context)))
        }
    }
}
