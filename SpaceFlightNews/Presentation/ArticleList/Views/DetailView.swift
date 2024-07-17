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
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .controlSize(.extraLarge)
//                    Image(systemName: "newspaper.fill")
//                        .resizable()
//                        .frame(width: 160, height: 160)
                }
                .frame(maxWidth: .infinity, minHeight: 160, alignment: .center)
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.title)
                    HStack {
                        Text(article.newsSite)
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text(article.publishedAt.convertToLongDateTimeFormat())
                            .font(.subheadline)
                    }
                    Text(shortenedSummary)
                    
                }
                .padding()
                Spacer()
            }
            .padding()
        }
        
    }
}

#Preview {
    DetailView(article: Article.preview)
}