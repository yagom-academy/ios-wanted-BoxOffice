//
//  CommentManager.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/03.
//

import Foundation
import FirebaseFirestore
import Combine

protocol CommentManagerable {
    func getComments(movieCd: String) -> AnyPublisher<[Comment], FireStoreError>
    func uploadComment(comment: Comment) -> AnyPublisher<Bool, FireStoreError>
}

final class CommentManager: CommentManagerable {
    
    private let firebaseManager: FirebaseManagerable
    private let jsonDecoder: JSONDecoder

    init(
        firebaseManager: FirebaseManagerable = FirebaseManager.share,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.firebaseManager = firebaseManager
        self.jsonDecoder = jsonDecoder
    }
    
    func getComments(movieCd: String) -> AnyPublisher<[Comment], FireStoreError> {
        return Future<[Comment], FireStoreError> { [weak self] promise in
            let publisher = self?.firebaseManager.read(collection: movieCd)
            _ = publisher?.sink(receiveCompletion: { _ in
                promise(.failure(.readError))
            }, receiveValue: { snapshot in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: snapshot)
                    if let commentArray = try self?.jsonDecoder.decode([Comment].self, from: jsonData) {
                        promise(.success(commentArray))
                    }
                } catch {
                    promise(.failure(.readError))
                }
            }
            )
       }.eraseToAnyPublisher()
    }
                            
    func uploadComment(comment: Comment) -> AnyPublisher<Bool, FireStoreError> {
        return firebaseManager.upload(data: comment)
    }
}
