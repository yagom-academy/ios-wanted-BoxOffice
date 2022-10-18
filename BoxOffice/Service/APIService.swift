//
//  APIService.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit


enum APIError: Error {
    case invalid
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static let shared = APIService()
    
    func fetchData<T: Decodable>(url: String, completion: @escaping(T?,APIError?) -> Void) {
        
        let urlString = url
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print(response)
                    completion(nil, .invalidData)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(T.self, from: data)
                    completion(responseData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
        }.resume()
        
    }
    
    func fetchImage<T: Decodable>(url: String, completion: @escaping(T?,APIError?) -> Void) {
        
        let urlString = url
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(APIKey.NAVER_KEY_ID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(APIKey.NAVER_KEY_SECRET, forHTTPHeaderField: "X-Naver-Client-Secret")
        
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id" : APIKey.NAVER_KEY_ID,
//            "X-Naver-Client-Secret" : APIKey.NAVER_KEY_SECRET
//        ]
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print(response)
                    completion(nil, .invalidData)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(T.self, from: data)
                    completion(responseData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
        }.resume()
        
    }
}
