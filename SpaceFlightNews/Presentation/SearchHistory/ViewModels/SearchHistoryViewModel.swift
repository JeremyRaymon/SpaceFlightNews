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
    @Published var alertIsPresented = false
    
    func loadSearchHistory() {
        searchHistories = cdm.searchHistories
    }
    
    func deleteSearchHistory(indexSet: IndexSet) {
        for index in indexSet {
            print(index)
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
}
