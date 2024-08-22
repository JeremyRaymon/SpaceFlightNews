//
//  MiniArticleListView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import SwiftUI

struct MiniArticleListView: View {
    @EnvironmentObject var vm: SearchHistoryViewModel
    let articles: [Article]
    
    var body: some View {
        VStack {
            Text("Data")
            ForEach(articles) { article in
                Button {
                    vm.toggleSheet(article: article)
                } label: {
                    Text("Data inside")
                    Text(article.title)
                        .font(.callout)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .deleteDisabled(true)
        }
    }
}

#Preview {
    MiniArticleListView(articles: [Article.preview])
}
