//
//  WeeklyViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/21.
//

import Foundation

final class WeeklyViewModel {
    let apiService = ApiService()
    
    func fetchWeeklyView(targetDt: String, weekGb: Int) async throws -> (WeeklyDTO, String) {
        let boxOfficeResultResponse = try await apiService.weeklyBoxOfficeAPIService(targetDt: targetDt, weekGb: weekGb)
        let showRange = boxOfficeResultResponse.boxOfficeResult.showRange
        let dto = WeeklyDTO(dataSource: [
            (section: .boxOffice,
             items: boxOfficeResultResponse.boxOfficeResult.weeklyBoxOfficeList.compactMap({ .boxOffice(BoxOfficeData($0)) }))
        ])
        
        return (dto, showRange)
    }
}
