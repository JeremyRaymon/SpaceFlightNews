//
//  Articles.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation

struct ArticlesWrapper: Codable {
    let results: [Article]
}

struct Article: Codable, Hashable {
    let id: Int
    let title: String
    let news_site: String
    
    static let preview = Article(id: 0, title: "Example Article", news_site: "Example News Site")
}
