//
//  FirebaseManager.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    let db = Firestore.firestore()
    
    func save(review: Review) {
        db.collection("review").document(review.password).setData(review.asDictionary!)
    }
    
    func update(review: Review) {
        db.collection("review").document(review.password).setData(
            review.asDictionary!,
            merge: true
        )
    }
    
    func delete(review: Review) {
        db.collection("review").document(review.password).delete()
    }
    
    func fetchAll() {
        db.collection("review").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    print(document.documentID)
                    print(document.data())
                }
            } else {
                
            }
        }
    }
}


