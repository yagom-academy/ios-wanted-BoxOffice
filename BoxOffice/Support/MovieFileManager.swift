//
//  MovieFileManager.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/22.
//

import Foundation

class MovieFileManager {
    static let shared = MovieFileManager()
    let fileManager = FileManager.default
    
    
    func saveReview(_ review: ReviewModel, movieTitle: String) {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsURL.appendingPathComponent(movieTitle)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true)
            } catch {
                NSLog("Couldn't create document directory")
            }
        }
        let fileURL = filePath.appendingPathComponent("\(review.nickname):\(movieTitle).json")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(review)
            try data.write(to: fileURL)
            print("파일메니저 성공!!!!")
        } catch {
            fatalError("Filemanager 업로드 실패")
        }
    }
    
    func getReviewPassword(_ review: ReviewModel, movieTitle: String) -> String {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsURL.appendingPathComponent(movieTitle).appendingPathComponent("\(review.nickname):\(movieTitle).json")
        
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode(ReviewModel.self, from: data)
            return decodeData.password
            
        } catch let error {
            fatalError("파일매니저 가져오기 실패: \(error)")
        }
        
    }
    
    
}
