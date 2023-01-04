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
    
    func fetchAll() {
        database.collection("review").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                guard let snapshot = snapshot else {
                    return
                }
                
                for document in snapshot.documents {
                    print(document.documentID)
                    print(document.data())
                }
            } 
        }
    }
}


