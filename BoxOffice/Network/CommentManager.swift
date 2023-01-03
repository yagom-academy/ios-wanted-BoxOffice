//
//  CommentManager.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/03.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

protocol CommentManagerable {
    func uploadComment(comment: Comment, errorHandler: @escaping (Error) -> Void)
    func getComments(movieCd: String, completion: @escaping ([Comment]?, Error?) -> Void)
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
    
    func getComments(movieCd: String, completion: @escaping ([Comment]?, Error?) -> Void) {
        let newCompletion: (QuerySnapshot?, Error?) -> Void = { query, error in
            do {
                guard let query = query else {
                    completion(nil, FireStoreError.readError)
                    return
                }
                let queryArray = query.documents
                var commentArray: [Comment] = []
                for query in queryArray {
                    let data = try query.data(as: Comment.self)
                    commentArray.append(data)
                }
                completion(commentArray, nil)
            } catch {
                completion(nil, FireStoreError.readError)
            }
        }
        firebaseManager.read(collection: movieCd, completion: newCompletion)
    }
    
    func uploadComment(comment: Comment, errorHandler: @escaping (Error) -> Void) {
        firebaseManager.upload(data: comment, errorHandler: errorHandler)
    }
}


