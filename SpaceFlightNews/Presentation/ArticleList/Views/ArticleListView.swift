//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var vm = ArticleListViewModel()
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView("Loading Articles")
                        .controlSize(.extraLarge)
                }
                else {
                    List {
                        Section {
                            Picker("News Site", selection: $vm.selectedNewsSite) {
                                Text("All").tag("All")
                                ForEach(vm.newsSites, id: \.self) { newssite in
                                    Text(newssite).tag(newssite)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        if vm.filteredArticles.isEmpty {
                            Section {
                                ContentUnavailableView("There is no article yet", systemImage: "newspaper.fill")
                            }
                            .listRowBackground(Color.clear)
                        } else {
                            ForEach(vm.filteredArticles, id: \.self) { article in
                                VStack {
                                    AsyncImage(url: URL(string: article.imageUrl)) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        ProgressView()
                                            .controlSize(.large)
                                            .frame(height: 160)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 160)
                                    
                                    NavigationLink(value: article) {
                                        NewsView(article: article)
                                    }
                                }
                                .onAppear(perform: {
                                    if vm.filteredArticles.last?.id == article.id {
                                        Task {
                                            try await vm.loadMoreArticles()
                                        }
                                    }
                                })
                            }
                        }
                        
                    }
                    .navigationDestination(for: Article.self, destination: DetailView.init)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                SearchHistoryView()
                            } label: {
                                Label("History", systemImage: "clock.arrow.circlepath")
                            }
                        }
                    })
                }
                
            }
            .navigationTitle("Articles")
            .searchable(text: $vm.searchText, placement: .toolbar, prompt: "Search Title...")
        }
        .padding(.bottom)
        .onSubmit(of: .search) {
            vm.saveSearchHistory(context: moc)
        }
        .task {
            do {
                vm.articles.append(contentsOf: try await NetworkManager.shared.fetchArticles())
                vm.newsSites = try await NetworkManager.shared.fetchNewsSites()
                vm.isLoading = false
            } catch {
                print("Error fetching articles")
            }
            
        }
    }
}

#Preview {
    ArticleListView()
}
