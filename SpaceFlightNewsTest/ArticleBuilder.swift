//
//  ArticleBuilder.swift
//  SpaceFlightNewsTests
//
//  Created by Jeremy Raymond on 21/07/24.
//

import Foundation
@testable import SpaceFlightNews

class ArticleBuilder {
    var id: Int = 20000
    var title: String = "Maxar unveils platform to speed up imagery access"
    var url: String = "https://spacenews.com/enhanced-dragon-spacecraft-to-deorbit-the-iss-at-the-end-of-its-life/"
    var imageUrl: String = "https://spacenews.com/maxar-unveils-platform-to-speed-up-imagery-access/"
    var newsSite: String = "SpaceNews"
    var summary: String = "MGP platform is designed to simplify and speed up access to the Colorado company’s high-resolution Earth imagery.Lorem Ipsum."
    var publishedAt: Date = Date.distantPast
    
    func with(id: Int) -> ArticleBuilder {
        self.id = id
        return self
    }
    
    func with(title: String) -> ArticleBuilder {
        self.title = title
        return self
    }
    
    func with(url: String) -> ArticleBuilder {
        self.url = url
        return self
    }
    
    func with(imageUrl: String) -> ArticleBuilder {
        self.imageUrl = imageUrl
        return self
    }
    
    func with(newsSite: String) -> ArticleBuilder {
        self.newsSite = newsSite
        return self
    }
    
    func with(summary: String) -> ArticleBuilder {
        self.summary = summary
        return self
    }
    
    func with(publishedAt: Date) -> ArticleBuilder {
        self.publishedAt = publishedAt
        return self
    }
    
    func build() -> Article {
        Article(id: id, title: title, url: url, imageUrl: imageUrl, newsSite: newsSite, summary: summary, publishedAt: publishedAt)
    }
    
    static let mockArticle = Article(
        id: 20000,
        title: "Maxar unveils platform to speed up imagery access",
        url: "https://spacenews.com/enhanced-dragon-spacecraft-to-deorbit-the-iss-at-the-end-of-its-life/",
        imageUrl: "https://spacenews.com/maxar-unveils-platform-to-speed-up-imagery-access/",
        newsSite: "SpaceNews",
        summary: "MGP platform is designed to simplify and speed up access to the Colorado company’s high-resolution Earth imagery.Lorem Ipsum.",
        publishedAt: Date()
    )
}
