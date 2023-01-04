//
//  FirebaseManager.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/03.
//

import Foundation
import FirebaseFirestore
import Combine


protocol FirebaseManagerable {
    func upload(data: FireStoreDatable, errorHandler: @escaping (Error) -> Void)
    func read(collection: String, completion: @escaping (QuerySnapshot?, Error?) -> Void)
    func delete(data: FireStoreDatable, errorHandler: @escaping (Error) -> Void)
}

enum FireStoreError: Error {
    case uploadError, readError, deleteError
}

final class FirebaseManager: FirebaseManagerable {
    
    private let db: Firestore
    static let share = FirebaseManager()
    
    private init() {
        db = Firestore.firestore()
    }
    
    func upload(data: FireStoreDatable, errorHandler: @escaping (Error) -> Void) {
        db.collection(data.collection).document(data.document).setData(data.toTupleData) { error in
            if let error = error {
                errorHandler(error)
            }
        }
    }
    
    func read(collection: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        db.collection(collection).getDocuments() { (querySnapshot, error) in
            if let querySnapshot = querySnapshot, error == nil {
                completion(querySnapshot, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func delete(data: FireStoreDatable, errorHandler: @escaping (Error) -> Void) {
        db.collection(data.collection).document(data.document).delete() { error in
            if error != nil {
                errorHandler(FireStoreError.deleteError)
            }
        }
    }
}
