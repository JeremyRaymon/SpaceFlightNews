//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchString = ""
    @State var articles: [Article] = []
    
    var body: some View {
        NavigationStack {
            List(articles, id: \.self) { article in
                NewsView(article: article)
            }
        }
        .searchable(text: $searchString, prompt: "Search Title...")
        .task {
            do {
                articles = try await NetworkManager.shared.fetchArticles()
            } catch {
                print("Error fetching articles")
            }
        }
    }
}

#Preview {
    ContentView()
}
