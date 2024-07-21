//
//  SearchHistoryViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 18/07/24.
//

import Foundation

class SearchHistoryViewModel: ObservableObject {
    let cdm = CoreDataManager.shared
    
    @Published var searchHistories: [SearchHistoryEntity] = []
    @Published private(set) var selectedArticle: Article = Article.preview
    @Published var alertIsPresented = false
    @Published var sheetIsPresented = false
    
    func loadSearchHistory() {
        searchHistories = cdm.searchHistories
    }
    
    func deleteSearchHistory(indexSet: IndexSet) {
        for index in indexSet {
            cdm.deleteSearchHistory(index: index)
        }
        loadSearchHistory()
    }
    
    func deleteAllSearchHistory() {
        cdm.deleteAllSearchHistory()
        loadSearchHistory()
    }
    
    func getArticleArray(searchHistory: SearchHistoryEntity) -> Array<ArticleEntity> {
        Array(searchHistory.articleentity as! Set<ArticleEntity>)
    }
    
    func toggleSheet(article: ArticleEntity) {
        self.sheetIsPresented.toggle()
        self.selectedArticle = entityToArticle(articleentity: article)
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
