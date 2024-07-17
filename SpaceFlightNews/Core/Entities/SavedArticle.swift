//
//  SavedArticle.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation

public class SavedArticle: NSObject, Codable {
    let id: Int
    let title: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: Date

    init(id: Int, title: String, imageUrl: String, newsSite: String, summary: String, publishedAt: Date) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
    }
}
