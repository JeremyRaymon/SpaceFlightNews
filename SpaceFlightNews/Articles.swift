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
    
    static let preview = Article(id: 0, title: "Example Article")
}
