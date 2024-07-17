//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var vm = ArticleListViewModel()
        
    var body: some View {
        NavigationStack {
            Picker("News Sites", selection: $vm.selectedNewsSite) {
                Text("All").tag("All")
                ForEach(vm.newsSites, id: \.self) { newssite in
                    Text(newssite).tag(newssite)
                }
            }
            .pickerStyle(.menu)
            List(vm.filteredArticles, id: \.self) { article in
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
        .searchable(text: $vm.searchText, prompt: "Search Title...")
        .onSubmit(of: .search) {
            print("submitted")
        }
        .task {
            do {
                vm.articles = try await NetworkManager.shared.fetchArticles()
                vm.newsSites = try await NetworkManager.shared.fetchNewsSites()
            } catch {
                print("Error fetching articles")
            }
        }
    }
}

#Preview {
    ArticleListView()
}
