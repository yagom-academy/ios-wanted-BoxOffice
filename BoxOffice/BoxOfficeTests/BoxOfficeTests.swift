//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by bard on 2023/01/02.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    func test_네트워킹없이테스트하기() {
        
        // given
        
        let request = KobisDailyBoxOfficeAPIRequest()
        let session = MockSession(url: "DailyBoxOfficeResultMockData", fileExtension: "json")
        var expectedResult: DailyBoxOfficeResponse?
        guard let mockData = loadMockData(url: "DailyBoxOfficeResultMockData", fileExtension: "json") else { return }
        let mockJsonData = try? JSONDecoder().decode(DailyBoxOfficeResponse.self, from: mockData)
        
        // when
        
        let expectation = expectation(description: "비동기 요청을 기다림.")

        session.execute(request) { (result: Result<DailyBoxOfficeResponse, APIError>) in
            switch result {
            case .success(let success):
                expectedResult = success
            case .failure(let failure):
                return
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 300)
        
        // then
        
        XCTAssertEqual(expectedResult?.boxOfficeResult.dailyBoxOfficeList, mockJsonData?.boxOfficeResult.dailyBoxOfficeList)
    }
    
    func test_KobisDailyBoxOfficeAPIRequest_withNetworking() {
        let request = KobisDailyBoxOfficeAPIRequest()
        let session = MyURLSession()
        
        let expectation = expectation(description: "비동기 요청을 기다림.")
        
        session.execute(request) { (result: Result<DailyBoxOfficeResponse, APIError>) in
            switch result {
            case .success(let success):
                success.boxOfficeResult.dailyBoxOfficeList.forEach { print($0.movieCode) }
//                success.boxOfficeResult.boxOfficeType
            case .failure(let failure):
                failure.localizedDescription
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 300)
    }
    
    func test_KobisWeeklyBoxOfficeAPIRequest_withNetworking() {
        let request = KobisWeeklyBoxOfficeAPIRequest()
        let session = MyURLSession()
        
        let expectation = expectation(description: "비동기 요청을 기다림.")
        
        session.execute(request) { (result: Result<WeeklyBoxOfficeResponse, APIError>) in
            switch result {
            case .success(let success):
                print(success)
                success.boxOfficeResult.weeklyBoxOfficeList.forEach { print($0.movieName) }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 300)
    }
    
//    func test_KobisMovieDetailAPIRequest_withNetworking() {
//        let request = KobisWeeklyBoxOfficeAPIRequest()
//        let session = MyURLSession()
//        
//        let expectation = expectation(description: "비동기 요청을 기다림.")
//        
//        session.execute(request) { (result: Result<WeeklyBoxOfficeResponse, APIError>) in
//            switch result {
//            case .success(let success):
//                print(success)
//                success.boxOfficeResult.weeklyBoxOfficeList.forEach { print($0.movieCode) }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 300)
//    }
    
    func test_KobisMovieDetailAPIRequest_withNetworking() {
        let request = KobisMovieDetailAPIRequest(movieCode: "20210028")
        let session = MyURLSession()
        
        let expectation = expectation(description: "비동기 요청을 기다림.")
        
        session.execute(request) { (result: Result<MovieDetailResponse, APIError>) in
            switch result {
            case .success(let success):
                print(success.movieDetailResult.movieDetail.actors)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 300)
    }
}

func loadMockData(url: String?, fileExtension: String?) -> Data? {
    guard let fileLocation = Bundle.main.url(
        forResource: url,
        withExtension: fileExtension
    ) else { return nil }
    var data: Data?
    
    do {
        data = try? Data(contentsOf: fileLocation)
    } catch {
        print("No Data")
    }
    
    return data
}

