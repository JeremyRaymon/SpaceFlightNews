//
//  SearchHistoryViewModelTests.swift
//  SpaceFlightNewsTest
//
//  Created by Jeremy Raymond on 16/08/24.
//

import XCTest
import CoreData
@testable import SpaceFlightNews

final class SearchHistoryViewModelTests: XCTestCase {
    var sut: SearchHistoryViewModel!
    var viewContext: NSManagedObjectContext!
    
    var mockSearchHistoryEntity: SearchHistoryEntity!
    var mockArticleEntity: ArticleEntity!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchHistoryViewModel(cdm: CoreDataManager.preview)
        viewContext = sut.cdm.container.viewContext
        sut.cdm.addSearchHistory(context: viewContext, searchText: "Test Search", articles: [ArticleBuilder.mockArticle])
        
        mockSearchHistoryEntity = sut.cdm.searchHistories.first
        mockArticleEntity = mockSearchHistoryEntity.articleentity!.anyObject() as? ArticleEntity
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testLoadSearchHistory() {
        sut.loadSearchHistory()
        
        XCTAssertTrue(!sut.searchHistories.isEmpty)
    }
    
    func testDeleteSearchHistory() {
        sut.cdm.addSearchHistory(context: viewContext, searchText: "Test Search 2", articles: [ArticleBuilder.mockArticle])
        sut.deleteSearchHistory(context: viewContext, indexSet: IndexSet(integer: 0))
        
        XCTAssertTrue(sut.searchHistories.count == 1)
    }
    
    func testDeleteAllSearchHistory() {
        sut.deleteAllSearchHistory(context: viewContext)
        
        XCTAssertTrue(sut.searchHistories.isEmpty)
    }
    
    func testGetArticleArray() {
        let articles = sut.getArticleArray(searchHistory: mockSearchHistoryEntity)
        
        XCTAssertTrue(!articles.isEmpty)
    }
    
    func testToggleSheet() {
        sut.toggleSheet(article: mockArticleEntity)
        
        XCTAssertTrue(sut.sheetIsPresented)
        XCTAssertTrue(sut.selectedArticle.title.contains(ArticleBuilder.mockArticle.title))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
