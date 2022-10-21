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
    }
    
    private func bind() {
        
    }
}
