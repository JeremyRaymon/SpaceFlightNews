//
//  DetailView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct DetailView: View {
    let article: Article
    
    var shortenedSummary: String {
        let sum = article.summary
        guard let dotIndex = sum.firstIndex(where: {$0 == "."}) else {
            return sum
        }
        let index = sum.distance(from: sum.startIndex, to: dotIndex)
        return String(article.summary.prefix(index) + ".")
    }
    
    var body: some View {
        Text(article.title)
        Text(article.imageUrl)
        Text(article.newsSite)
        Text(shortenedSummary)
        Text(article.publishedAt.convertToLongDateTimeFormat())
    }
}

#Preview {
    DetailView(article: Article.preview)
}
