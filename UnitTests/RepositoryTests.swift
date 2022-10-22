//
//  RepositoryTests.swift
//  UnitTests
//
//  Created by CodeCamper on 2022/10/18.
//

import XCTest
import Combine
import FirebaseStorage
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
        var result: [Movie]?
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
        var result: [Movie]?
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
    
    func test_getMovieReviews() {
        // given
        let movieCode = "20112207"
        let expectation = self.expectation(description: "Wait for API")
        var result: [Review]?
        
        // when
        repository.getMovieReviews(movieCode)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                result = $0
                expectation.fulfill()
            }).store(in: &subscriptions)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_putMovieReviews() {
        // given
        let movieCode = "20112207"
        let review = Review(nickname: "다온솜", photo: UIImage(named: "circle")?.pngData(), rating: 5, password: "#123abcd", content: "안녕하세요")
        let expectation = self.expectation(description: "Wait for API")
        var result: StorageMetadata?
        
        // when
        repository.putMovieReviews(movieCode, review: review)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                result = $0
                expectation.fulfill()
            }).store(in: &subscriptions)
        
        waitForExpectations(timeout: 10)
        
        // then
        XCTAssertNotNil(result)
    }
}
