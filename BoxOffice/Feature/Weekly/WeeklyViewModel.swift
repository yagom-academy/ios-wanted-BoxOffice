//
//  WeeklyViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/21.
//

import Foundation

final class WeeklyViewModel {
    let apiService = ApiService()
    
    func fetchWeeklyView() async throws -> WeeklyBoxOfficeResultResponse {
        let result = try await apiService.weeklyBoxOfficeAPIService(targetDt: "20120101")
        return result
    }
}
