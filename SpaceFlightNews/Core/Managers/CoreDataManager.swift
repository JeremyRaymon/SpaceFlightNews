//
//  CoreDataManager.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    let container = NSPersistentContainer(name: "PersistentStorage")
    var searchHistories: [SearchHistoryEntity] = []
    
    private init() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.searchHistories = self.fetchSearchHistories()
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func fetchSearchHistories() -> [SearchHistoryEntity] {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
        
        do {
            searchHistories = try context.fetch(request)
        } catch {
            print("Error fetching search histories: \(error)")
        }
        
        return searchHistories
    }
    
    func addSearchHistory(searchHistory: SearchHistory) {
        let searchHistoryEntity = SearchHistoryEntity(context: context)
        searchHistoryEntity.searchText = searchHistory.searchText
        searchHistoryEntity.articles = searchHistory.articles
        
        save()
    }
    
    func deleteSearchHistory(index: Int) {
        let searchHistory = searchHistories[index]
        context.delete(searchHistory)
        self.searchHistories.remove(at: index)
        save()
    }
    
    func deleteAllSearchHistory() {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
        let searchHistories = try? context.fetch(request)
        
        for searchHistory in searchHistories ?? [] {
            context.delete(searchHistory)
        }
        self.searchHistories.removeAll()
        
        save()
    }
}
