//
//  APIService.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

final class ApiService {
    
    func getRequestData<T: Codable>(type: T.Type, path: String, parameters: [String: Any]? = nil) {
        let baseURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/"
        let urlString = baseURL + path
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        if let parameters = parameters {
            let urlQueryItemList = parameters.compactMap { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            
            urlComponents.queryItems = urlQueryItemList
        }
        
        guard let url = urlComponents.url else { return }
        let session = URLSession(configuration: .default)
        print(#function, url)
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode.isSuccessCode {
                do {
                    let list = try JSONDecoder().decode(type.self, from: data)
                    print(#function, list)
                } catch(let error) {
                    print(String(describing: error))
                    return
                }
            }
        }.resume()
    }
}
