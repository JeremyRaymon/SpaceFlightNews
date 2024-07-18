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
        setArticleTransformer()
        
        container.loadPersistentStores { storeDescription, error in
//            self.deleteAllSearchHistory()
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.fetchSearchHistories()
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func setArticleTransformer() {
        ValueTransformer.setValueTransformer(SavedArticleTransformer(), forName: NSValueTransformerName("SavedArticleTransformer"))
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
            self.fetchSearchHistories()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func fetchSearchHistories() {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
        
        do {
            searchHistories = try context.fetch(request)
            print(searchHistories.count)
            for searchHistory in searchHistories {
                print(searchHistory.articleentity?.count)
            }
        } catch {
            print("Error fetching search histories: \(error)")
        }
    }
    
    func addSearchHistory(searchText: String, articles: [Article]) {
        let searchHistoryEntity = SearchHistoryEntity(context: context)
        searchHistoryEntity.searchText = searchText
        for article in articles {
            addArticle(article: article, searchHistory: searchHistoryEntity)
        }
//        print(searchHistoryEntity.articleentity?.title)
//        searchHistoryEntity.articles = articles
        
        save()
    }
    
    func addArticle(article: Article, searchHistory: SearchHistoryEntity) {
        let articleEntity = ArticleEntity(context: context)
        articleEntity.id = Int32(article.id)
        articleEntity.title = article.title
        articleEntity.newssite = article.newsSite
        articleEntity.summary = article.summary
        articleEntity.searchhistoryentity = searchHistory
        
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
