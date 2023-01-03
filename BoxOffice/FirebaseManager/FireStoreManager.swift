//
//  FireStoreManager.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/02.
//

import UIKit
import FirebaseFirestore

final class FireStoreManager {
    static let shared = FireStoreManager()
    private let database = Firestore.firestore()
    private let deviceID: String
    
    private init() {
        guard let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString else {
            deviceID = ""
            return
        }
        deviceID = deviceIdentifier
    }
    
    func save(_ data: [String: Any], with id: String) {
        database.collection(deviceID).document(id).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
        }
    }
    
    func delete(id: String) {
        database.collection(deviceID).document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
    
    func fetch(completionHandler: @escaping ([QueryDocumentSnapshot]) -> Void) {
        database.collection(deviceID).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            if let documents = querySnapshot?.documents {
                completionHandler(documents)
            }
        }
    }
}

