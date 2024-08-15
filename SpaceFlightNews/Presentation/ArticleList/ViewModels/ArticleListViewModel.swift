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
    
    @Published var searchText = ""
    @Published var selectedNewsSite = "All"
    @Published var articles: [Article] = []
    @Published var newsSites: [String] = []
    @Published var isLoading = true
    
    var offset: Int = 0
    
    init(networkService: NetworkService, coreDataManager: CoreDataManager, articles: [Article] = []) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
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
        self.newsSites = try await networkService.fetchNewsSites()
    }
    
    @MainActor
    func fetchArticles() async throws {
        articles.append(contentsOf: try await NetworkManager.shared.fetchArticles(offset: offset))
        offset += 10
    }
    
    func saveSearchHistory(context: NSManagedObjectContext) {
        coreDataManager.addSearchHistory(context: context, searchText: searchText, articles: filteredArticles)
    }
}
