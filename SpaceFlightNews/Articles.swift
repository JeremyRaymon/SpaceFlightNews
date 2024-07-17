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
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: Date
//    let published_at: String
    
    static let preview = Article(
        id: 20000,
        title: "Maxar unveils platform to speed up imagery access",
        imageUrl: "https://spacenews.com/maxar-unveils-platform-to-speed-up-imagery-access/",
        newsSite: "SpaceNews",
        summary: "MGP platform is designed to simplify and speed up access to the Colorado company’s high-resolution Earth imagery.",
        publishedAt: Date()
    )
}
