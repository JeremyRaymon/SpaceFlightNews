//
//  ArticleListViewModelTests.swift
//  SpaceFlightNewsTests
//
//  Created by Jeremy Raymond on 21/07/24.
//

import XCTest
@testable import SpaceFlightNews 

final class ArticleListViewModelTests: XCTestCase {
    var sut: ArticleListViewModel!
    let cdm = CoreDataManager.preview
    
    let mockArticles = [
        ArticleBuilder().with(id: 1).with(title: "First Title").with(newsSite: "Third NewsSite").build(),
        ArticleBuilder().with(id: 2).with(title: "Second Title").with(newsSite: "Second NewsSite").build(),
        ArticleBuilder().with(id: 3).with(title: "Third Title").with(newsSite: "First NewsSite").build(),
     ]
    
    func testEmptySearch() {
        sut.searchText = ""
        XCTAssertEqual(sut.filteredArticles, sut.articles)
    }
    
    func testFilterText() {
        sut.searchText = "First"
        XCTAssertEqual(sut.filteredArticles.first, sut.articles.first)
    }
    
    func testFilterNewsSite() {
        sut.selectedNewsSite = "First NewsSite"
        XCTAssertEqual(sut.filteredArticles.first, sut.articles.last)
    }
    
    func testFilterTextAndNewsSite() {
        sut.searchText = "First"
        sut.selectedNewsSite = "Third NewsSite"
        XCTAssertEqual(sut.filteredArticles.first, sut.articles.first)
    }
    
    func testSaveSearchHistory() {
        sut.searchText = "Test Search"
        sut.saveSearchHistory(context: cdm.container.viewContext)
        XCTAssert(cdm.searchHistories.contains(where: {$0.searchText == sut.searchText}))
    }

    override func setUpWithError() throws {
        sut = ArticleListViewModel(networkService: NetworkManager.shared, coreDataManager: cdm, articles: mockArticles)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
