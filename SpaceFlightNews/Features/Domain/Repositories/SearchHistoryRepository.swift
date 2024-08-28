//
//  SearchHistoryRepository.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import Foundation
import CoreData

struct SearchHistoryRepository: SearchHistoryUseCasesProtocol {
    let coreDataManager: CoreDataManager

    func fetchSearchHistories() -> [SearchHistory] {
        return coreDataManager.searchHistories.map {
            coreDataManager.entityToSearchHistory(searchHistoryEntity: $0)
        }
    }

    func saveSearchHistory(searchText: String, articles: [Article]) throws {
        coreDataManager.addSearchHistory(searchText: searchText, articles: articles)
    }

    func deleteSearchHistory(byIndex index: Int) throws {
        coreDataManager.deleteSearchHistory(index: index)
    }

    func deleteAllSearchHistories() throws {
        coreDataManager.deleteAllSearchHistory()
    }
}

