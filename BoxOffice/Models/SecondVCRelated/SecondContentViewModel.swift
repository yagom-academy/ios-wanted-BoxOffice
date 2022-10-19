//
//  SecondContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import Foundation

class SecondContentViewModel {
    
    //input
    var didReceiveEntity: (KoficMovieDetailEntity) -> () = { entity in }
    
    //output
    @MainThreadActor var didReceiveViewModel: ( ((Void)) -> () )?
    
    //properties
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity in
            guard let self = self else { return }
            self.populateEntity(result: entity)
            self.didReceiveViewModel?(())
        }
    }
    
    private func populateEntity(result: KoficMovieDetailEntity) {
        
    }
}
