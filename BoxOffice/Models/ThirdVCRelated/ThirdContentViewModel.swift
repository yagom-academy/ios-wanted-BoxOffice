//
//  ThirdContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import Foundation

class ThirdContentViewModel: ObservableObject {
    //input
    
    //output
    @Published var photo: String = ""
    @Published var nickName: String = "닉네임닉네임"
    @Published var passcode: String = "패스코드패스코드"
    @Published var starRate: String = "스타레이트"
    @Published var reviewContent: String = "리뷰컨텐트컨텐트"
    
    //properties
    
    init() {
        
    }
}
