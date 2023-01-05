//
//  FirebaseManager.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    private let collectionType: FirebaseModel
    private let database = Firestore.firestore()
    
    init(collectionType: FirebaseModel) {
        self.collectionType = collectionType
    }
    
    func save(review: Review) {
        do {
            let reviewDictionary = try review.asDictionary()
            
            database.collection("review").document(review.password).setData(reviewDictionary)
        } catch {
            print(error)
        }
    }
    
    func update(review: Review) {
        do {
            let reviewDictionary = try review.asDictionary()
            
            database.collection("review").document(review.password).setData(reviewDictionary, merge: true)
        } catch let error {
            print(error)
        }
    }
    
    func delete(review: Review) {
        database.collection("review").document(review.password).delete()
    }
    
    func fetchAll(completionHandler: @escaping ([Review]) -> Void) {
        database.collection("review").getDocuments { (querySnapshot, error) in
            var reviews: [Review] = []
            
            if error == nil && querySnapshot != nil {
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                for document in documents {
                    do {
                        let data = document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let review = try decoder.decode(Review.self, from: jsonData)
                        reviews.append(review)
                    } catch let error {
                        print(error)
                    }
                }
                completionHandler(reviews)
            }
        }
    }
}


