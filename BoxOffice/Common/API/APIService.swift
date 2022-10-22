//
//  APIService.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

final class ApiService {
    
    private func getRequestData<T: Codable>(type: T.Type, path: String, parameters: [String: Any]? = nil) async throws -> T {
        
        let baseURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/"
        let urlString = baseURL + path
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw APIError.invalidURL
        }
        if let parameters = parameters {
            let urlQueryItemList = parameters.compactMap { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            
            urlComponents.queryItems = urlQueryItemList
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
         httpResponse.statusCode.isSuccessCode else {
           throw APIError.failHTTPStatus
        }
        
        do {
            guard let responseData = try? JSONDecoder().decode(type.self, from: data) else {
                throw APIError.failResponseDecording
            }
            return responseData
        } catch {
            print("\(error)")
            throw APIError.failResponseDecording
        }
    }
    
    func dailyBoxOfficeAPIService(targetDt: String) async throws -> DailyBoxOfficeResultResponse {
        return try await getRequestData(
            type: DailyBoxOfficeResultResponse.self,
            path: ListType.daily.path,
            parameters: [
                "key" : "f5eef3421c602c6cb7ea224104795888",
                "targetDt" : targetDt,
                "wideAreaCd" : "0105001"
            ]
        )
    }
    
    func weeklyBoxOfficeAPIService(targetDt: String, weekGb: Int) async throws -> WeeklyBoxOfficeResultResponse {
        return try await getRequestData(
            type: WeeklyBoxOfficeResultResponse.self,
            path: ListType.weekly.path,
            parameters: [
                "key" : "f5eef3421c602c6cb7ea224104795888",
                "targetDt" : targetDt,
                "wideAreaCd" : "0105001",
                "weekGb" : "\(weekGb)"
            ]
        )
    }
}
