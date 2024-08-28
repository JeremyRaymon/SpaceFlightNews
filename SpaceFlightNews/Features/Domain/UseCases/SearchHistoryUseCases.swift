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
        return repository.fetchSearchHistories()
    }

    func saveSearchHistory(searchText: String, articles: [Article]) throws {
        try repository.saveSearchHistory(searchText: searchText, articles: articles)
    }

    func deleteSearchHistory(byIndex index: Int) throws {
        try repository.deleteSearchHistory(byIndex: index)
    }

    func deleteAllSearchHistories() throws {
        try repository.deleteAllSearchHistories()
    }
}

