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
    var firstContentViewModel: FirstContentViewModel {
        return privateFirstContentViewModel
    }
    
    //properties
    private var privateFirstContentViewModel: FirstContentViewModel
    
    // TODO: Repository
    init() {
        self.privateFirstContentViewModel = FirstContentViewModel()
        
        bind()
    }
    
    private func bind() {
        
    }
}
