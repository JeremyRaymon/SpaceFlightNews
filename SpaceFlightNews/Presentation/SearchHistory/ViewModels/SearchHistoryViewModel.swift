//
//  SearchHistoryViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 18/07/24.
//

import Foundation

class SearchHistoryViewModel: ObservableObject {
    @Published var searchHistories: [SearchHistoryEntity] = []
    
    func loadSearchHistory() {
        searchHistories = CoreDataManager.shared.searchHistories
    }
    
    func deleteAllSearchHistory() {
        CoreDataManager.shared.deleteAllSearchHistory()
        loadSearchHistory()
    }
}
