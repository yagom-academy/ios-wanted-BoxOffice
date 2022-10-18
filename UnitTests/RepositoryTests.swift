//
//  RepositoryTests.swift
//  UnitTests
//
//  Created by CodeCamper on 2022/10/18.
//

import XCTest
import Combine
@testable import BoxOffice

class RepositoryTests: XCTestCase {
    var repository: Repository!
    var subscriptions = [AnyCancellable]()
    
    override func setUpWithError() throws {
        repository = Repository()
    }
    
    override func tearDownWithError() throws {
        repository = nil
        subscriptions = []
    }
    
    func test_dailyBoxOffice() {
        // given
        var result: [BoxOffice]?
        let expectation = self.expectation(description: "Wait for API")
        
        // when
        repository.dailyBoxOffice("20221017")
            .sink(receiveCompletion: {
                print("Receive Completion: \($0)")
            }, receiveValue: { boxOffice in
                result = boxOffice
                expectation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_weeklyBoxOffice() {
        // given
        var result: [BoxOffice]?
        let expectation = self.expectation(description: "Wait for API")
        
        // when
        repository.weeklyBoxOffice("20221016", weekGb: .weekly)
            .sink(receiveCompletion: {
                print("Receive Completion: \($0)")
            }, receiveValue: { boxOffice in
                result = boxOffice
                expectation.fulfill()
            }).store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
}
