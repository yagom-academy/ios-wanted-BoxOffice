//
//  DailyViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/19.
//

import Foundation

final class DailyViewModel {
    let apiService = ApiService()
    
    func fetchDailyView(_ targetDt: String) async throws -> DailyDTO {
        let boxOfficeResultResponse = try await apiService.dailyBoxOfficeAPIService(targetDt: targetDt)
        
//        var dto = DailyDTO(dataSource: [(section: .dateSelector, items: [.dateSelector])])
        
        let dto = DailyDTO(dataSource: [
            (section: .boxOffice,
             items: boxOfficeResultResponse.boxOfficeResult.dailyBoxOfficeList.compactMap({ .boxOffice(BoxOfficeData($0)) }))
        ])
        
        return dto
    }
}
