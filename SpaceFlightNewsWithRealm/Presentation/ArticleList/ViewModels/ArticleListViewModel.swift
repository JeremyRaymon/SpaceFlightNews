//
//  ArticleListViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import CoreData

class ArticleListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedNewsSite = "All"
    @Published var articles: [Article] = []
    @Published var newsSites: [String] = []
    @Published var isLoading = true
    
    var offset: Int = 0
    
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
    
    init(articles: [Article] = []) {
        self.articles = articles
    }
    
    @MainActor
    func loadMoreArticles() async throws {
        offset += 10
        articles.append(contentsOf: try await NetworkManager.shared.fetchArticles(offset: offset))
    }
    
    func saveSearchHistory(context: NSManagedObjectContext) {
        CoreDataManager.shared.addSearchHistory(context: context, searchText: searchText, articles: filteredArticles)
    }
}
