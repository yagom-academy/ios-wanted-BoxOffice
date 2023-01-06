//
//  FirebaseManager.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

class FirebaseManager {
    static let shared =  FirebaseManager()
    
    private(set) var reviews = [[String : Any]]()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func save(_ model: LoginModel, movieName: String) {
        db.collection(movieName).document(model.nickname).setData([
            "image": model.image,
            "password": model.password,
            "star": model.star,
            "content": model.content,
            "nickname": model.nickname
        ]) { error in
            if let error = error {
                print(error)
            }
        }
    }

    func fetch(movieName: String, handler: (@escaping ([[String : Any]]) -> Void)) {
        db.collection(movieName).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = querySnapshot {
                    self.reviews = [[String : Any]]()
                    for document in data.documents {
                        self.reviews.append(document.data())
                    }
                    handler(self.reviews)
                }
            }
        }
    }

    func delete(movieName: String, nickname: String) {
        db.collection(movieName).document(nickname).delete() { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage(movieName: String, nickname: String, handler: (@escaping (UIImage) -> Void)) {
        db.collection(movieName).document(nickname).getDocument { (document, error)  in
            if let document = document,
               let dataDescription = document.data(),
                document.exists {
                if let test = dataDescription["image"] as? String,
                   let image = test.imageFromBase64 {
                    handler(image)
                }
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
}
