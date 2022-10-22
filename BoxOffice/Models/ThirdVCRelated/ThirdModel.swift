//
//  ThirdModel.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class ThirdModel {
    //input
    
    //output
    var thirdContentViewModel: ThirdContentViewModel {
        return privateThirdContentViewModel
    }
    
    //properties
    var privateThirdContentViewModel: ThirdContentViewModel = ThirdContentViewModel()
    
    init() {
        
    }
    
}
