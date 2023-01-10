//
//  StorageManager.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/02.
//

import UIKit
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private let storageReference = Storage.storage().reference()
    private let deviceID: String
    
    private init() {
        guard let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString else {
            deviceID = ""
            return
        }
        deviceID = deviceIdentifier
    }
    
    func save(_ image: UIImage,
              id: String,
              completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        storageReference.child("\(deviceID)/\(id)").putData(imageData, metadata: nil) { _, error in
            if error != nil {
                completion(.failure(.save))
            }
            
            completion(.success(()))
        }
    }
    
    func delete(widh id: String,
                completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        storageReference.child("\(deviceID)/\(id)").delete { error in
            if error != nil {
                completion(.failure(.delete))
            }
            
            completion(.success(()))
        }
    }
    
    func fetch(with id: String, completion: @escaping (UIImage?) -> Void) {
        let size: Int64 = 1 * 1024 * 1024
        
        storageReference.child("\(deviceID)/\(id)").getData(maxSize: size) { data, error in
            if error != nil {
                completion(nil)
            }
            
            if let data = data {
                completion(UIImage(data: data))
            }
        }
    }
}
