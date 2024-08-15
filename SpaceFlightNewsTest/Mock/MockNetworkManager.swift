//
//  MockNetworkManager.swift
//  SpaceFlightNewsTest
//
//  Created by Jeremy Raymond on 15/08/24.
//

import SwiftUI
@testable import SpaceFlightNews

class MockNetworkManager: NetworkService {
    func fetchArticles(offset: Int) async throws -> [SpaceFlightNews.Article] {
        let mockArticles = [ArticleBuilder.mockArticle, ArticleBuilder.mockArticle, ArticleBuilder.mockArticle]
        return mockArticles
    }
    
    func fetchNewsSites() async throws -> [String] {
        let mockNewsSites = ["News Site 1", "News Site 2", "News Site 3"]
        return mockNewsSites
    }
    
    func downloadImage(url: String) async throws -> Data {        
        return UIImage(named: "AppIcon")?.pngData() ?? Data()
    }
    
    
}
