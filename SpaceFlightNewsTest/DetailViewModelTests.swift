//
//  DetailViewModelTests.swift
//  SpaceFlightNewsTests
//
//  Created by Jeremy Raymond on 21/07/24.
//

import XCTest
@testable import SpaceFlightNews

final class DetailViewModelTests: XCTestCase {
    var sut: DetailViewModel!
    
    override func setUp() {
        sut = DetailViewModel(article: ArticleBuilder().with(summary: "LoremIpsum.LoremIpsum").build())
    }
    
    func testShortenedSummary() {
        XCTAssertEqual(sut.shortenedSummary, "LoremIpsum.")
    }
    
    func testNoDotShortenedSummary() {
        sut = DetailViewModel(article: ArticleBuilder().with(summary: "LoremIpsum").build())
        XCTAssertEqual(sut.shortenedSummary, "LoremIpsum")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
