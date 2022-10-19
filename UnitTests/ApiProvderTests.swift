//
//  UnitTests.swift
//  UnitTests
//
//  Created by CodeCamper on 2022/10/18.
//

import XCTest
import Combine
@testable import BoxOffice


final class ApiProvderTests: XCTestCase {
    var subscriptions = [AnyCancellable]()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        subscriptions = []
    }

    func test_dailyBoxOfficeList_API() throws {
        // given
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: "20221018")
        let expecation = self.expectation(description: "ApiProviderTest")
        var result: DailyBoxOfficeListResponse?
        
        // when
        ApiProvider.shared.request(KobisAPI.dailyBoxOfficeList(param))
            .map { $0.data }
            .decode(type: DailyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print("Receive Completion: \($0)")}, receiveValue: { list in
                result = list
                expecation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_weeklyBoxOfficeList_API() throws {
        // given
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: "20221017", weekGb: .weekly)
        let expecation = self.expectation(description: "ApiProviderTest")
        var result: WeeklyBoxOfficeListResponse?
        
        // when
        ApiProvider.shared.request(KobisAPI.weeklyBoxOfficeList(param))
            .map { $0.data }
            .decode(type: WeeklyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print("Receive Completion: \($0)")}, receiveValue: { list in
                result = list
                expecation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_movieDetail_API() throws {
        // given
        let param = MovieDetailRequest(key: Environment.kobisKey, movieCd: "20124079")
        let expectation = self.expectation(description: "ApiProviderTest")
        var result: MovieDetailResponse?
        
        //when
        ApiProvider.shared.request(KobisAPI.movieDetail(param))
            .map { $0.data }
            .decode(type: MovieDetailResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print("Receive Completion: \($0)") },
                  receiveValue: { detail in
                result = detail
                expectation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_moviePoster_API() throws {
        // given
        let param = MoviePosterRequest(apikey: Environment.omdbKey, t: "Confidential Assignment 2: International")
        let expectation = self.expectation(description: "ApiProviderTest")
        var result: MoviePosterResponse?
        
        // when
        ApiProvider.shared.request(OmdbAPI.moviePoster(param))
            .map(\.data)
            .decode(type: MoviePosterResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print("Receive Completion: \($0)") },
                  receiveValue: { response in
                result = response
                expectation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
}
