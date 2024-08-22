//
//  SearchHistoryViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 18/07/24.
//

import Foundation
import CoreData

class SearchHistoryViewModel: ObservableObject {
    let searchHistoryUseCase = SearchHistoryUseCases(repository: SearchHistoryRepository(coreDataManager: CoreDataManager.shared))
    
    @Published var searchHistories: [SearchHistory] = []

    @Published private(set) var selectedArticle: Article = Article.preview
    @Published var alertIsPresented = false
    @Published var sheetIsPresented = false
    
    func loadSearchHistory() {
        self.searchHistories = searchHistoryUseCase.fetchSearchHistories()
    }
    
    func deleteSearchHistory(indexSet: IndexSet) {
        for index in indexSet {
            do {
                try searchHistoryUseCase.deleteSearchHistory(byIndex: index)
            } catch {
                
            }
            
        }
        loadSearchHistory()
    }
    
    func deleteAllSearchHistory() {
        do {
            try searchHistoryUseCase.deleteAllSearchHistories()
        } catch {
            
        }
        
        loadSearchHistory()
    }
    
    func getArticleArray(searchHistory: SearchHistoryEntity) -> Array<ArticleEntity> {
        Array(searchHistory.articleentity as! Set<ArticleEntity>)
    }
    
    func toggleSheet(article: Article) {
        self.sheetIsPresented.toggle()
        self.selectedArticle = article
    }
    
    private func entityToArticle(articleentity: ArticleEntity) -> Article {
        Article(
            id: Int(articleentity.id),
            title: articleentity.title ?? Article.preview.title,
            url: articleentity.url ?? Article.preview.url,
            imageUrl: articleentity.image ?? Article.preview.imageUrl,
            newsSite: articleentity.newssite ?? Article.preview.newsSite,
            summary: articleentity.summary ?? Article.preview.summary,
            publishedAt: articleentity.publishedAt ?? Date()
        )
    }
}
