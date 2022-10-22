//
//  File.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/22.
//

import Foundation
import Firebase
import FirebaseStorage

protocol FirestorageDelegate {
  func didFetchedReviews(_ review: ReviewModel, _ fileName: String)
}

class FireStorageManager {
  static let shared = FireStorageManager()

  var delegate: FirestorageDelegate?

  let storage = Storage.storage()
  let decoder = JSONDecoder()
  let encoder = JSONEncoder()

  func uploadReview(movieCode: String, fileName: String, reviewInfo: ReviewModel) {
    let storageRef = storage.reference().child(movieCode).child(fileName + ".json")
    let metaData = StorageMetadata()
    guard let data = encodeJSON(reviewInfo) else { return }

    metaData.contentType = "json"
    storageRef.putData(data, metadata: metaData,
    completion: { meta, error in
      if let error = error {
        print("metadata error: \(error)")
      } else {
        storageRef.downloadURL(completion: { url, error in
          guard let downloadURL = url else {
            print("downloadURL error")
            return
          }
          print("downloadURL: \(downloadURL)")
        })
      }
    })
  }

  func fetchReview(movieCode: String) {
    let storageRef = storage.reference().child(movieCode)

    storageRef.listAll(completion: { result, error in
      if let error = error {
        print("fetch review error: \(error)")
      } else {
        for item in result!.items {
          item.getData(maxSize: 1024 * 1024, completion: { data, error in
            if let error = error {
              print("get data error: \(error)")
            } else {
              let decoded = self.decodeJSON(data!)
              self.delegate?.didFetchedReviews(decoded!, item.name)
            }
          })
        }
      }
    })
  }

  func deleteReview(movieCode: String, fileName: String) {
    let storageRef = storage.reference().child(movieCode).child(fileName)

    storageRef.delete { error in
      if let error = error {
        print("delete review error in fireStorage: \(error)")
      } else {
        print("delete review success in fireStorage")
      }
    }
  }

  func encodeJSON(_ data: ReviewModel) -> Data? {
    do {
      let encodedData = try encoder.encode(data)

      return encodedData
    } catch {
      print("encoding error")
      return nil
    }
  }

  func decodeJSON(_ resultData: Data) -> ReviewModel? {
    do {
      let decodedData = try decoder.decode(ReviewModel.self, from: resultData)

      return decodedData
    } catch {
      print("parse posterInfo JSON error")
      return nil
    }
  }

}
