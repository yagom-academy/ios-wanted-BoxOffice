//
//  FirebaseStorageManager.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/22.
//

import UIKit
import FirebaseStorage
import Firebase

class FirebaseStorageManager {
    
    static let shared = FirebaseStorageManager()
    
    let storage = Storage.storage()
    
    lazy var storageRef = storage.reference()
    
    func uploadImage(image:UIImage,filePath:String){
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = filePath + "Image"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data,metadata: metaData) { metaData, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }else{
                print("성공")
            }
        }
    }
    
    func uploadData(_ review:ReviewModel,filePath:String){
        do{
            let data = try JSONEncoder().encode(review)
         //   let filePath = UUID().uuidString
            storage.reference().child(filePath).putData(data)
        }catch{
            print(error.localizedDescription)
        }
    }
    func downloadImage(urlString:String,imageView:UIImageView){
        let storageReference = storage.reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else { return }
            imageView.image = UIImage(data: imageData)
        }
    }
    
//    func downloadImage(urlString:String) -> UIImage?{
//        let storageReference = storage.reference(forURL: urlString)
//        var image : UIImage?
//        let megaByte = Int64(1 * 1024 * 1024)
//        storageReference.getData(maxSize: megaByte) { data, error in
//            guard let imageData = data else { return }
//            image = UIImage(data: imageData)
//        }
//        return image
//    }
    
    func download(urlString:String){
        let storageReference = storage.reference(forURL: urlString)
        var review : ReviewModel?
        let megaByte = Int64(1 * 1024 * 1024)
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let data = data, error == nil else {
                return }
            do{
                let reviewData = try JSONDecoder().decode(ReviewModel.self, from: data)
                review = reviewData
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(){
        let deleteRef = storageRef.child("password")
        deleteRef.delete { error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("성공")
            }
        }
    }


}
