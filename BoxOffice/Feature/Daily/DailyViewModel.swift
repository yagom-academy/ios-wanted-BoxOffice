//
//  DailyViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/19.
//

import UIKit

final class DailyViewModel {
    let apiService = ApiService()
    
    func fetchDailyView() async throws -> DailyBoxOfficeResultResponse {
        let result = try await apiService.dailyBoxOfficeAPIService(targetDt: "20120101")
        return result
    }
}
