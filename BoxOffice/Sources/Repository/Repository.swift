//
//  Repository.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    
}

class Repository {
    let apiProvider: ApiProviderProtocol
    
    init(apiProvider: ApiProviderProtocol = ApiProvider.shared) {
        self.apiProvider = apiProvider
    }
    
    func dailyBoxOffice(_ targetDt: String) -> AnyPublisher<[BoxOffice], Error> {
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: targetDt)
        return apiProvider.request(KobisAPI.dailyBoxOfficeList(param), useCaching: false)
            .receive(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: DailyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .map { Translator.translate($0) }
            .eraseToAnyPublisher()
    }
    
    func weeklyBoxOffice(_ targetDt: String, weekGb: BoxOfficeListRequest.WeekGubun) -> AnyPublisher<[BoxOffice], Error> {
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: targetDt, weekGb: weekGb)
        return apiProvider.request(KobisAPI.weeklyBoxOfficeList(param), useCaching: false)
            .receive(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: WeeklyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .map { Translator.translate($0) }
            .eraseToAnyPublisher()
    }
}
