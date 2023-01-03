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
    func upload(data: FireStoreDatable) -> AnyPublisher<Bool, FireStoreError>
    func read(collection: String) -> AnyPublisher<QuerySnapshot, FireStoreError>
}

enum FireStoreError: Error {
    case uploadError, readError
}

final class FirebaseManager: FirebaseManagerable {
    
    private let db: Firestore
    static let share = FirebaseManager()
    
    private init() {
        db = Firestore.firestore()
    }
    
    func upload(data: FireStoreDatable) -> AnyPublisher<Bool, FireStoreError> {
        return Future<Bool, FireStoreError> { [weak self] promise in
            self?.db.collection(data.collection).document(data.document).setData(data.toTupleData) { error in
                if error != nil {
                    promise(.failure(.uploadError))
                } else {
                    promise(.success(true))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func read(collection: String) -> AnyPublisher<QuerySnapshot, FireStoreError> {
        return Future<QuerySnapshot, FireStoreError> { [weak self] promise in
            self?.db.collection(collection).getDocuments() { (querySnapshot, error) in
                if let querySnapshot = querySnapshot, error == nil {
                    promise(.success(querySnapshot))
                } else {
                    promise(.failure(.readError))
                }
            }
        }.eraseToAnyPublisher()
    }
}
