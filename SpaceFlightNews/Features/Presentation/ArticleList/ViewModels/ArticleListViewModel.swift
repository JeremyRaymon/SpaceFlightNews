//
//  ArticleListViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import CoreData

class ArticleListViewModel: ObservableObject {
    let networkService: NetworkService
    let coreDataManager: CoreDataManager
    let context: NSManagedObjectContext
    
    let searchHistoryUseCases: SearchHistoryUseCases
    
    @Published var searchText = ""
    @Published var selectedNewsSite = "All"
    @Published var articles: [Article] = []
    @Published var newsSites: [String] = []
    @Published var isLoading = true
    
    var offset: Int = 0
    
    init(networkService: NetworkService, coreDataManager: CoreDataManager, context: NSManagedObjectContext,  articles: [Article] = []) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
        self.context = context
        self.articles = articles
        self.searchHistoryUseCases = SearchHistoryUseCases(repository: SearchHistoryRepository(coreDataManager: CoreDataManager.shared, context: context))
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
        self.newsSites = try await networkService.fetchNewsSites()
    }
    
    @MainActor
    func fetchArticles() async throws {
        articles.append(contentsOf: try await NetworkManager.shared.fetchArticles(offset: offset))
        offset += 10
    }
    
    func saveSearchHistory(context: NSManagedObjectContext) {
        do {
            try searchHistoryUseCases.saveSearchHistory(searchText: searchText, articles: filteredArticles)

        } catch {
            
        }
//        coreDataManager.addSearchHistory(context: context, searchText: searchText, articles: filteredArticles)
    }
}
