//
//  ArticleObject.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/07/24.
//

import Foundation
import RealmSwift

class SearchHistoryObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var searchText: String
//    @Persisted var articles: List<ArticleObject>
}

class ArticleObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var summary: String
    @Persisted var newssite: String
    @Persisted var publishedAt: Date
    @Persisted var image: String
    @Persisted var url: String
}

//extension ArticleObject {
//    func convertToArticle() -> Article {
//        Article(id: self.id, title: self.title, url: self.url, imageUrl: self.image, newsSite: self.newssite, summary: self.summary, publishedAt: self.publishedAt)
//    }
//}
