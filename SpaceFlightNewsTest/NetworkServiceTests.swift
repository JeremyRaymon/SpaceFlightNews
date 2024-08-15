//
//  NetworkServiceTests.swift
//  SpaceFlightNewsTest
//
//  Created by Jeremy Raymond on 15/08/24.
//

import XCTest
@testable import SpaceFlightNews


final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testFetchArticles() async throws {
        let articles = try await sut.fetchArticles(offset: 0)
        XCTAssertNotNil(articles)
    }
    
    func testFetchNewsSites() async throws {
        let newssites = try await sut.fetchNewsSites()
        XCTAssertNotNil(newssites)
    }
    
    func testDownloadImage() async throws {
        let image = try await sut.downloadImage(url: "https://picsum.photos/200/300")
        XCTAssertNotNil(image)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
