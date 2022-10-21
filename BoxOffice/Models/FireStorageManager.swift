//
//  File.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FireStorageManager {
  static let shared = FireStorageManager()

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

  }

  func deleteReview() {

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
