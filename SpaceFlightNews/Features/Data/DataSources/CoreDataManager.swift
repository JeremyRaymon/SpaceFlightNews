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

extension ArticleEntity {
    func toArticle() -> Article {
        Article(
            id: Int(self.id),
            title: self.title ?? Article.preview.title,
            url: self.url ?? Article.preview.url,
            imageUrl: self.image ?? Article.preview.imageUrl,
            newsSite: self.newssite ?? Article.preview.newsSite,
            summary: self.summary ?? Article.preview.summary,
            publishedAt: self.publishedAt ?? Date()
        )
    }
    
}

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    let container = NSPersistentContainer(name: "PersistentStorage")
    var searchHistories: [SearchHistoryEntity] = []
    
    static var preview: CoreDataManager = {
        let result = CoreDataManager(inMemory: true)
        return result
    }()
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.fetchSearchHistories()
        }
    }
    
    func entityToSearchHistory(searchHistoryEntity: SearchHistoryEntity) -> SearchHistory {
        SearchHistory(
            searchText: searchHistoryEntity.searchText!,
            articles: searchHistoryEntity.articleentity?.compactMap({ entity in
                let articleEntity = entity as! ArticleEntity
                return articleEntity.toArticle()
            }) ?? []
        )
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
            self.fetchSearchHistories()
        } catch {
            print(CoreDataError.saveError)
        }
    }
    
    func fetchSearchHistories() {
        let request = NSFetchRequest<SearchHistoryEntity>(entityName: "SearchHistoryEntity")
                
        do {
            searchHistories = try context.fetch(request)
        } catch {
            print(CoreDataError.fetchError)
        }
    }
    
    func addSearchHistory(searchText: String, articles: [Article]) {
        let searchHistoryEntity = SearchHistoryEntity(context: context)
        searchHistoryEntity.searchText = searchText
        for article in articles {
            addArticle(article: article, searchHistory: searchHistoryEntity)
        }
        
        save()
    }
    
    func addArticle(article: Article, searchHistory: SearchHistoryEntity) {
        let articleEntity = ArticleEntity(context: context)
        articleEntity.id = Int32(article.id)
        articleEntity.title = article.title
        articleEntity.image = article.imageUrl
        articleEntity.newssite = article.newsSite
        articleEntity.summary = article.summary
        articleEntity.url = article.url
        
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
