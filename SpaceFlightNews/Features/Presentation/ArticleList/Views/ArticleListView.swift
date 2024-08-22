//
//  ContentView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI
import CoreData

struct ArticleListView: View {
    @ObservedObject var vm: ArticleListViewModel
    @Environment(\.managedObjectContext) var moc
    
    init(context: NSManagedObjectContext) {
        self.vm = ArticleListViewModel(networkService: NetworkManager.shared, coreDataManager: CoreDataManager.shared, context: context)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView("Loading Articles")
                        .controlSize(.extraLarge)
                        .accessibilityIdentifier("LoadingIndicator")
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
                            .accessibilityIdentifier("News Site")
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
                                            try await vm.fetchArticles()
                                        }
                                    }
                                })
                            }
                        }
                        
                    }
                    .accessibilityIdentifier("List")
                    .navigationDestination(for: Article.self) { article in
                        DetailView(vm: DetailViewModel(article: article))
                    }
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                SearchHistoryView(context: moc)
                            } label: {
                                Label("History", systemImage: "clock.arrow.circlepath")
                                    .accessibilityIdentifier("History")
                            }
                            
                        }
                    })
                }
            }
            .navigationTitle("Articles")
            .searchable(text: $vm.searchText, placement: .toolbar, prompt: "Search Title...")
            .autocorrectionDisabled()
        }
        .padding(.bottom)
        .onSubmit(of: .search) {
            vm.saveSearchHistory(context: moc)
//            vm.saveSearchHistory(context: moc)
        }
        .task {
            do {
                try await vm.fetchArticles()
                try await vm.fetchNewsSites()
                vm.isLoading = false
            } catch {
                print("Error fetching articles")
            }
        }
    }
}

//#Preview {
//    ArticleListView()
//}
