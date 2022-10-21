//
//  FirebaseStorage.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/21.
//

import UIKit
import FirebaseStorage

class FirebaseStorage {
    static let shared = FirebaseStorage()
    let storage = Storage.storage()
    
    //TEST CODE
    func imageUpload(url: URL, completion: @escaping(URL)->() ){
        // Create a root reference
        let storageRef = storage.reference()
        // Create a reference to 'images/테스트이미지.jpg'
        let imageRef = storageRef.child("images/" + url.lastPathComponent)
        
        // Data in memory
        var data = Data()
        data = try! Data(contentsOf: url)
        
        // Upload the file to the path "images/테스트이미지.jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        imageRef.putData(data, metadata: metadata) { (metadata, error) in
            //print(error)
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            //print(metadata)
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                completion(downloadURL)
                //return downloadURL
            }
        }
    }
    
    func dataUpload(movieName: String, data: Review, completion: @escaping()->() ){
        // Create a root reference
        let storageRef = storage.reference()
        // Create a reference
        let dataRef = storageRef.child(movieName + "/" + data.id.uuidString)
        
        // Data in memory
        let jsonData = try! JSONEncoder().encode(data)
        
        // Upload the file to the path "images/테스트이미지.jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "application/json"
        dataRef.putData(jsonData, metadata: metadata) { (metadata, error) in
            //print(error)
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            completion()
        }
    }
    
    func fireBasefetchData(movieName: String, completion: @escaping(Review)->()) {
        
        var items: [StorageReference] = []
        let storageReference = storage.reference().child(movieName)
        storageReference.listAll { (result, error) in
            if let error = error {
                print(error)
            }
            for prefixe in result!.prefixes {
                print(prefixe)
                // The prefixes under storageReference.
                // You may call listAll(completion:) recursively on them.
            }
            for item in result!.items {
                items.append(item)
                // The items under storageReference.
            }
            items.forEach { dataRef in
                dataRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        guard let data = data else { return }
                        let jsonString = try! JSONDecoder().decode(Review.self, from: data)
                        completion(jsonString)
                    }
                }
                
            }
        }
    }
    
    func deleteData(id: UUID, movieName: String, completion: @escaping()->()) {
        // Create a root reference
        let storageRef = storage.reference()
        
        // Create a reference to 'images/테스트이미지.jpg'
        let dataRef = storageRef.child(movieName + "/\(id)")
        
        // Delete the file
        dataRef.delete { error in
            if let error = error {
                print(error)
            } else {
                // File deleted successfully
                completion()
            }
        }
    }
}
