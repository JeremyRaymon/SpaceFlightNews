//
//  MockCoreDataManager.swift
//  SpaceFlightNewsTest
//
//  Created by Jeremy Raymond on 15/08/24.
//

import Foundation
import CoreData
@testable import SpaceFlightNews

class MockCoreDataManager: ObservableObject {
    static let shared = MockCoreDataManager()
    let container = NSPersistentContainer(name: "PersistentStorage")
    var searchHistories: [SearchHistoryEntity] = []

    init() {
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.fetchSearchHistories(context: self.container.viewContext)
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
}
