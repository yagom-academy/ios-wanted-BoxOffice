//
//  BoxOfficeRepository.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation
import Combine

protocol BoxOfficeRepository {
    
    func dailyBoxOffice(date targetDt: Date) -> AnyPublisher<[Movie], Error>
    func weeklyBoxOffice(date targetDt: Date, weekGb: BoxOfficeListRequest.WeekGubun) -> AnyPublisher<[Movie], Error>
    func movieInfo(code movieCd: String) -> AnyPublisher<MovieDetailInfo, Error>
    func moviePoster(name movieNameEnglish: String) -> AnyPublisher<String, Error>
    
}
