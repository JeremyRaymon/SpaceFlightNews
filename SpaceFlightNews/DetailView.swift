//
//  DetailView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct DetailView: View {
    let article: Article
    
    var body: some View {
        Text(article.title)
        Text(article.imageUrl)
        Text(article.newsSite)
        Text(article.summary)
        Text(article.publishedAt.convertToLongDateTimeFormat())
    }
}

#Preview {
    DetailView(article: Article.preview)
}
