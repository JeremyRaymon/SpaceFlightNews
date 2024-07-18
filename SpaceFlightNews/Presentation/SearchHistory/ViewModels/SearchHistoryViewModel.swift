//
//  SearchHistoryViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 18/07/24.
//

import Foundation

class SearchHistoryViewModel: ObservableObject {
    @Published var searchHistories: [SearchHistoryEntity] = []
    let cdm = CoreDataManager.shared
    
    func loadSearchHistory() {
        searchHistories = cdm.searchHistories
    }
    
    func deleteSearchHistory(indexSet: IndexSet) {
        for index in indexSet {
            print(index)
            cdm.deleteSearchHistory(index: index)
        }
    }
    
    func deleteAllSearchHistory() {
        cdm.deleteAllSearchHistory()
        loadSearchHistory()
    }
}
