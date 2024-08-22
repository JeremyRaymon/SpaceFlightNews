//
//  SearchHistoryUseCases.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import Foundation

protocol SearchHistoryUseCasesProtocol {
    func fetchSearchHistories() -> [SearchHistory]
    func saveSearchHistory(searchText: String, articles: [Article]) throws
    func deleteSearchHistory(byIndex index: Int) throws
    func deleteAllSearchHistories() throws
}

class SearchHistoryUseCases: SearchHistoryUseCasesProtocol {
    private let repository: SearchHistoryRepository

    init(repository: SearchHistoryRepository) {
        self.repository = repository
    }

    func fetchSearchHistories() -> [SearchHistory] {
        // Use the repository to fetch search histories
        return repository.fetchSearchHistories()
    }

    func saveSearchHistory(searchText: String, articles: [Article]) throws {
        // Use the repository to save a new search history
        try repository.saveSearchHistory(searchText: searchText, articles: articles)
    }

    func deleteSearchHistory(byIndex index: Int) throws {
        // Use the repository to delete a specific search history entry
        try repository.deleteSearchHistory(byIndex: index)
    }

    func deleteAllSearchHistories() throws {
        // Use the repository to delete all search history entries
        try repository.deleteAllSearchHistories()
    }
}

