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
    let ns: NetworkService = MockNetworkManager()
    
    let mockArticles = [
        ArticleBuilder().with(id: 1).with(title: "First Title").with(newsSite: "Third NewsSite").build(),
        ArticleBuilder().with(id: 2).with(title: "Second Title").with(newsSite: "Second NewsSite").build(),
        ArticleBuilder().with(id: 3).with(title: "Third Title").with(newsSite: "First NewsSite").build(),
     ]
    
    override func setUpWithError() throws {
        sut = ArticleListViewModel(networkService: ns, coreDataManager: cdm, articles: mockArticles)
    }
    
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
    
    func testFetchArticles() async throws {
        sut = ArticleListViewModel(networkService: ns, coreDataManager: cdm, articles: [])
        
        try await sut.fetchArticles()
        
        XCTAssertNotNil(sut.articles)
    }
    
    func testFetchNewsSites() async throws {
        try await sut.fetchNewsSites()
        
        XCTAssertNotNil(sut.newsSites)
    }
    
    func testSaveSearchHistory() {
        sut.searchText = "Test Search"
        sut.saveSearchHistory(context: cdm.container.viewContext)
        XCTAssert(cdm.searchHistories.contains(where: {$0.searchText == sut.searchText}))
    }

    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
