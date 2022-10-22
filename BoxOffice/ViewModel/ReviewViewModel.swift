//
//  ReviewViewModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import Foundation

class ReviewViewModel {
    var movieName: String = ""
    var nickname: String = ""
    var password: String = ""
    var score: Int = 0
    var text: String = ""
    var uploadImageURL: URL?
    var downloadImageURL: String = ""
    var jsonData: Data?
    
    func sendData(completion: @escaping ()->() ) -> Int{
        
        //필수 텍스트가 비어있나 확인
        if textIsEmpty() {
            return 1
        }
        //비밀번호 유효성
        if !validPassword(password: password) {
            return 2
        }
        
        
        //사진이 있을 경우
        if let url = uploadImageURL {
            FirebaseStorage.shared.imageUpload(url: url) { downloadURL in
                self.downloadImageURL = downloadURL.absoluteString
                self.dataToJsonString {
                    completion()
                }
            }
        //사진이 없을 경우
        } else {
            dataToJsonString {
                completion()
            }
        }
        
        return 0
        
    }
    
    func checkText(text: String) -> Bool {
        let trimText = text.trimmingCharacters(in: .whitespaces)
        if trimText.isEmpty {
            return true
        } else {
            return false
        }
        
    }
    
    func textIsEmpty() -> Bool{
        if checkText(text: nickname) {
            return true
        } else if checkText(text: password) {
            return true
        } else if checkText(text: text) {
            return true
        } else {
            return false
        }
    }
    
    func dataToJsonString(completion: @escaping () -> ()) {
        let data = Review(nickname: self.nickname, password: self.password, score: self.score, text: self.text, imageURL: self.downloadImageURL, id: UUID())
        
        FirebaseStorage.shared.dataUpload(movieName: movieName, data: data) {
            completion()
        }

        
    }
    
    func validPassword(password : String) -> Bool {
        
            let passwordreg =  ("(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$]).{6,20}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: password)
        
        }
}
