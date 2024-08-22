//
//  SearchHistoryRepository.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import Foundation
import CoreData

protocol SearchHistoryRepositoryProtocol {
    func fetchSearchHistories() -> [SearchHistory]
    func saveSearchHistory(searchText: String, articles: [Article]) throws
    func deleteSearchHistory(byIndex index: Int) throws
    func deleteAllSearchHistories() throws
}

struct SearchHistoryRepository: SearchHistoryRepositoryProtocol {
    private let coreDataManager: CoreDataManager
    private let context: NSManagedObjectContext

    init(coreDataManager: CoreDataManager, context: NSManagedObjectContext) {
        self.coreDataManager = coreDataManager
        self.context = context
    }

    func fetchSearchHistories() -> [SearchHistory] {
        return coreDataManager.searchHistories.map {
            coreDataManager.entityToSearchHistory(searchHistoryEntity: $0)
        }
    }

    func saveSearchHistory(searchText: String, articles: [Article]) throws {
//        let context = coreDataManager.container.viewContext
        coreDataManager.addSearchHistory(context: context, searchText: searchText, articles: articles)
    }

    func deleteSearchHistory(byIndex index: Int) throws {
//        let context = coreDataManager.container.viewContext
        coreDataManager.deleteSearchHistory(context: context, index: index)
    }

    func deleteAllSearchHistories() throws {
        let context = coreDataManager.container.viewContext
        coreDataManager.deleteAllSearchHistory(context: context)
    }
}

