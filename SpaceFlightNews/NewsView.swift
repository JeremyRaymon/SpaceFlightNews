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
        VStack(alignment: .leading) {
            Text(article.title)
            Text(article.newsSite)
                .font(.caption)
                .bold()
        }
        
    }
}

#Preview {
    NewsView(article: Article.preview)
}
