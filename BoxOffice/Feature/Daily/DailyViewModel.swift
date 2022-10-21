//
//  DailyViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/19.
//

import Foundation

final class DailyViewModel {
    let apiService = ApiService()
    
    func fetchDailyView() async throws -> DailyDTO {
        let boxOfficeResultResponse = try await apiService.dailyBoxOfficeAPIService(targetDt: "20120101")
        
        var dto = DailyDTO(dataSource: [(section: .dateSelector, items: [.dateSelector])])
        
        dto.dataSource.append(
            (section: .boxOffice, items:
                boxOfficeResultResponse.boxOfficeResult.dailyBoxOfficeList.compactMap({ .boxOffice(BoxOfficeData($0)) })
            )
        )
        
        return dto
    }
}
