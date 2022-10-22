//
//  DetailViewModel.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

final class DetailViewModel {
    let apiService = ApiService()
    
    func fetchDetailView(boxOfficeData: BoxOfficeData) async throws -> DetailDTO {
        let movieInfoResultResponse = try await apiService.movieInfoAPIService(movieCd: boxOfficeData.movieCd)
        
        var dto = DetailDTO(dataSource: [
            (section: .movieInfo,
             items: [.movieInfoWithBoxOffice(boxOfficeData)])
        ])
        
        dto.dataSource.append(
            (section: .movieInfo,
             items: [.movieInfo(MovieInfoData(movieInfoResultResponse.movieInfoResult.movieInfo))])
        )
        
        return dto
    }
}
