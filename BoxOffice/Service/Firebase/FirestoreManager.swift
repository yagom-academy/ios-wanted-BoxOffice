//
//  FireStoreManager.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/02.
//

import UIKit
import FirebaseFirestore

final class FirestoreManager {
    static let shared = FirestoreManager()
    private let database = Firestore.firestore()
    
    private init() { }
    
    func save(_ data: [String: Any],
              at collection: String,
              with id: String,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        database.collection(collection).document(id).setData(data) { error in
            if error != nil {
                completion(.failure(.save))
            }
            
            completion(.success(()))
        }
    }
    
    func delete(with id: String,
                at collection: String,
                completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        database.collection(collection).document(id).delete { error in
            if error != nil {
                completion(.failure(.delete))
            }
            
            completion(.success(()))
        }
    }
    
    func fetch(at collection: String,
                completion: @escaping (Result<[QueryDocumentSnapshot], FirebaseError>) -> Void) {
        database.collection(collection).getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(.fetch))
            }
            
            if let documents = querySnapshot?.documents {
                completion(.success(documents))
            }
        }
    }
}

