//
//  PersistentManager.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import Foundation

class PersistentManager {
    static let shared = PersistentManager()
    let defaults = UserDefaults.standard
    let key = "SearchHistory"
    var searchHistories: [String] = []
    
    private init() { }
    
    func addSearchHistory(searchHistory: String) {
        self.searchHistories.append(searchHistory)
        self.defaults.set(searchHistories, forKey: self.key)
    }
    
    func deleteSearchHistory(index: IndexSet) {
        self.searchHistories.remove(atOffsets: index)
        self.defaults.set(searchHistories, forKey: self.key)
    }
    
    func deleteAllSearchHistory() {
        self.defaults.removeObject(forKey: self.key)
    }
    
    func fetchSearchHistories() -> [String] {
        self.defaults.array(forKey: self.key) as? [String] ?? []
    }
}
