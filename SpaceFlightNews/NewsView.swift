//
//  NewsView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct NewsView: View {
    let article: Article
    
    var body: some View {
        Text(article.title)
    }
}

#Preview {
    NewsView(article: Article.preview)
}
