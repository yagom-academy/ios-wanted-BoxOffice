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
    private let deviceID: String
    
    private init() {
        guard let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString else {
            deviceID = ""
            return
        }
        deviceID = deviceIdentifier
    }
    
    func save(_ data: [String: Any],
              with id: String,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        database.collection(deviceID).document(id).setData(data) { error in
            if error != nil {
                completion(.failure(.save))
            }
            
            completion(.success(()))
        }
    }
    
    func delete(with id: String,
                completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        database.collection(deviceID).document(id).delete { error in
            if error != nil {
                completion(.failure(.delete))
            }
            
            completion(.success(()))
        }
    }
    
    func fetch(completion: @escaping (Result<[QueryDocumentSnapshot], FirebaseError>) -> Void) {
        database.collection(deviceID).getDocuments { querySnapshot, error in
            if error != nil {
                completion(.failure(.fetch))
            }
            
            if let documents = querySnapshot?.documents {
                completion(.success(documents))
            }
        }
    }
}

