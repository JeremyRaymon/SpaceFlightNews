//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchString = ""
    @State var selectedNewsSite = "All"
    @State var articles: [Article] = []
    @State var newsSites: [String] = []
    
    var body: some View {
        NavigationStack {
            Picker("News Sites", selection: $selectedNewsSite) {
                Text("All").tag("All")
                ForEach(newsSites, id: \.self) { newssite in
                    Text(newssite).tag(newssite)
                }
            }
            .pickerStyle(.menu)
            List(filteredArticles, id: \.self) { article in
                NavigationLink(value: article) {
                    NewsView(article: article)
                }
            }
            .navigationDestination(for: Article.self, destination: DetailView.init)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Button pressed")
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                }
            })
        }
        .searchable(text: $searchString, prompt: "Search Title...")
        
        .task {
            do {
                articles = try await NetworkManager.shared.fetchArticles()
                newsSites = try await NetworkManager.shared.fetchNewsSites()
            } catch {
                print("Error fetching articles")
            }
        }
    }
    
    var filteredArticles: [Article] {
        var filteredArticles = articles
        if !searchString.isEmpty {
            filteredArticles = filteredArticles.filter{ $0.title.localizedStandardContains(searchString)}
        }
        if selectedNewsSite != "All" {
            filteredArticles = filteredArticles.filter{$0.newsSite.elementsEqual(selectedNewsSite) }
        }
        return filteredArticles
    }
}

#Preview {
    ContentView()
}
