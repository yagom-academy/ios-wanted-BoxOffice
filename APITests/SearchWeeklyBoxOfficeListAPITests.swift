//
//  SearchWeeklyBoxOfficeListAPITests.swift
//  APITests
//
//  Created by 이원빈 on 2023/01/02.
//

import XCTest
@testable import BoxOffice

final class SearchWeeklyBoxOfficeListAPITests: XCTestCase {
    var sut: SearchWeeklyBoxOfficeListAPI!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchWeeklyBoxOfficeListAPI(date: "20221010", weekOption: .allWeek)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_SearchWeeklyBoxOfficeListAPI_테스트() {
        // given
        var response: WeeklyBoxOfficeListResponseDTO?
        let expectation = XCTestExpectation(description: "SearchWeeklyBoxOfficeListAPI Test")
        // when
        sut.execute { result in
            switch result {
            case .success(let success):
                print(success)
                response = success
                expectation.fulfill()
            case .failure(let error):
                print(String(describing: error))
            }
        }
        wait(for: [expectation], timeout: 3.0)
        
        // then
        XCTAssertNotNil(response)
    }
}
