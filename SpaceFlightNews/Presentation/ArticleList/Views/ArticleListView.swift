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
            List {
                ForEach(vm.filteredArticles, id: \.self) { article in
                    VStack {
                        AsyncImage(url: URL(string: article.imageUrl)) { image in
                            image
                                .resizable()
                        } placeholder: {
                            ProgressView()
                                .controlSize(.large)
                                .frame(height: 128)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 128)
                        
                        NavigationLink(value: article) {
                            NewsView(article: article)
                        }
                    }
                    .onAppear(perform: {
                        if vm.filteredArticles.last?.id == article.id {
                            print("Reached last: \(article.id)")
                            Task {
                                try await vm.loadMoreArticles()
                            }
                        }
                    })
                }
            }
            .navigationDestination(for: Article.self, destination: DetailView.init)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchHistoryView()
                    } label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        
                    }
                }
            })
        }
        .padding(.bottom)
        .searchable(text: $vm.searchText, prompt: "Search Title...")
        .onSubmit(of: .search) {
            vm.saveSearchHistory()
        }
        .onAppear {
            Task {
                do {
                    vm.articles.append(contentsOf: try await NetworkManager.shared.fetchArticles())
                    vm.newsSites = try await NetworkManager.shared.fetchNewsSites()
                } catch {
                    print("Error fetching articles")
                }
            }
            
        }
    }
}

#Preview {
    ArticleListView()
}
