//
//  CoreDataManager.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import CoreData

enum CoreDataError: String, Error {
    case fetchError = "Error fetching data"
    case saveError = "Error saving data"
}

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    let container = NSPersistentContainer(name: "PersistentStorage")
    var searchHistories: [SearchHistoryEntity] = []
    
    static var preview: CoreDataManager = {
        let result = CoreDataManager(inMemory: true)
//        let viewContext = result.container.viewContext
//        result.createSampleData()
        return result
    }()
    
    private init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.fetchSearchHistories(context: self.container.viewContext)
        }
    }
    
    func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
            self.fetchSearchHistories(context: context)
        } catch {
            print(CoreDataError.saveError)
        }
    }
    
    func fetchSearchHistories(context: NSManagedObjectContext) {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
        
        do {
            searchHistories = try context.fetch(request)
        } catch {
            print(CoreDataError.fetchError)
        }
    }
    
    func addSearchHistory(context: NSManagedObjectContext, searchText: String, articles: [Article]) {
        let searchHistoryEntity = SearchHistoryEntity(context: context)
        searchHistoryEntity.searchText = searchText
        for article in articles {
            addArticle(context: context, article: article, searchHistory: searchHistoryEntity)
        }
        
        save(context: context)
    }
    
    func addArticle(context: NSManagedObjectContext, article: Article, searchHistory: SearchHistoryEntity) {
        let articleEntity = ArticleEntity(context: context)
        articleEntity.id = Int32(article.id)
        articleEntity.title = article.title
        articleEntity.image = article.imageUrl
        articleEntity.newssite = article.newsSite
        articleEntity.summary = article.summary
        articleEntity.url = article.url
        
        articleEntity.searchhistoryentity = searchHistory
        save(context: context)
    }
    
    func deleteSearchHistory(context: NSManagedObjectContext, index: Int) {
        let searchHistory = searchHistories[index]
        context.delete(searchHistory)
        self.searchHistories.remove(at: index)
        save(context: context)
    }
    
    func deleteAllSearchHistory(context: NSManagedObjectContext) {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
        let searchHistories = try? context.fetch(request)
        
        for searchHistory in searchHistories ?? [] {
            context.delete(searchHistory)
        }
        self.searchHistories.removeAll()
        
        save(context: context)
    }
}
