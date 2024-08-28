//
//  ArticleListViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import CoreData

class ArticleListViewModel: ObservableObject {
    let searchHistoryUseCase = SearchHistoryUseCases(repository: SearchHistoryRepository(coreDataManager: CoreDataManager.shared))
    let articleUseCase = ArticleUseCases(articleRepository: ArticleRepository(networkService: NetworkManager.shared))
    
    @Published var searchText = ""
    @Published var selectedNewsSite = "All"
    @Published var articles: [Article] = []
    @Published var newsSites: [String] = []
    @Published var isLoading = true
    
    var offset: Int = 0
    
    init(articles: [Article] = []) {
        self.articles = articles
    }
    
    var filteredArticles: [Article] {
        var filteredArticles = articles
        if !searchText.isEmpty {
            filteredArticles = filteredArticles.filter{ $0.title.localizedStandardContains(searchText)}
        }
        if selectedNewsSite != "All" {
            filteredArticles = filteredArticles.filter{$0.newsSite.elementsEqual(selectedNewsSite) }
        }
        return filteredArticles
    }
    
    @MainActor
    func fetchNewsSites() async throws {
        self.newsSites = try await articleUseCase.fetchNewsSites()
    }
    
    @MainActor
    func fetchArticles() async throws {
        articles.append(contentsOf: try await articleUseCase.fetchArticles(offset: offset))
        offset += 10
    }
    
    func saveSearchHistory() {
        do {
            try searchHistoryUseCase.saveSearchHistory(searchText: searchText, articles: filteredArticles)
        } catch {
            
        }

    }
}
