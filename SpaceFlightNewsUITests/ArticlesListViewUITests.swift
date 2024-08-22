//
//  ArticlesListViewUITests.swift
//  SpaceFlightNewsUITests
//
//  Created by Jeremy Raymond on 15/08/24.
//

import XCTest
@testable import SpaceFlightNews

final class ArticlesListViewUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArticleListView() throws {
        let app = XCUIApplication()
        
        // Test Loading State
        let loadingIndicator = app.activityIndicators["LoadingIndicator"]
        XCTAssertTrue(loadingIndicator.exists, "Loading indicator should be visible while articles are being fetched")
        
        // Test News Site Picker
        let picker = app.staticTexts["News Site"]
        XCTAssertTrue(picker.waitForExistence(timeout: 10), "News Site picker should be visible")
        
        // Test Search Functionality
        let searchField = app.searchFields["Search Title..."]
        XCTAssertTrue(searchField.exists, "Search bar should exist in the toolbar")
        searchField.tap()
        searchField.typeText("SpaceX")
        
        app.keyboards.buttons["Search"].tap()
        
        if app.cells.count > 0 {
            let searchResult = app.cells.firstMatch
            XCTAssertTrue(searchResult.exists, "Search results should be displayed")
        }
        
//        let historyButton = app.otherElements["History"]
//        XCTAssertTrue(historyButton.exists, "History Button should exist in toolbar")
    }
}
