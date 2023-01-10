//
//  APITests.swift
//  APITests
//
//  Created by 이원빈 on 2023/01/02.
//

import XCTest
@testable import BoxOffice

final class SearchDailyBoxOfficeListAPITests: XCTestCase {
    var sut: SearchDailyBoxOfficeListAPI!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchDailyBoxOfficeListAPI(date: "20221010")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_SearchDailyBoxOfficeListAPI_테스트() {
        // given
        var response: DailyBoxOfficeListResponseDTO?
        let expectation = XCTestExpectation(description: "SearchDailyBoxOfficeListAPI Test")
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
