//
//  ReviewViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import Foundation

class ReviewViewModel {
    var nickname: String = ""
    var password: String = ""
    var score: Int = 0
    var text: String = ""
    var imageURL: String = ""
    
    func sendData() -> Bool {
        
        if checkText(text: nickname) {
            return false
        } else if checkText(text: password) {
            return false
        } else if checkText(text: text) {
            return false
        } else {
            return true
        }
        
    }
    
    func checkText(text: String) -> Bool {
        let trimText = text.trimmingCharacters(in: .whitespaces)
        if trimText.isEmpty {
            return true
        } else {
            return false
        }
        
    }
}
