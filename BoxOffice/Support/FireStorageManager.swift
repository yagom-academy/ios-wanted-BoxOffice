//
//  FireStorageManager.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/22.
//

import Foundation
import FirebaseStorage

class FireStorageManager {
    static let shared = FireStorageManager()
    private let storage = Storage.storage()
    
    func uploadReview(review: ReviewModel, movieTitle: String) {
        let reviewName = "\(review.nickname) : \(movieTitle)"
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let data = try jsonEncoder.encode(review)
            let storageRef = storage.reference().child("\(reviewName)")
            let metaData = StorageMetadata()
            metaData.contentType = "json"
            storageRef.putData(data, metadata: metaData) { metaData, error in
                if let error = error {
                    print("metadata error: \(error)")
                } else {
                    print("🎉 Upload Success")
                }
            }
        } catch {
            fatalError("🚨ERROR: Review encode fail")
        }
        
    }
    

}
