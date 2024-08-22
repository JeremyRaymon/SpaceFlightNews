//
//  SearchHistoryView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI
import CoreData

struct SearchHistoryView: View {
    @ObservedObject var vm: SearchHistoryViewModel
    
    init(context: NSManagedObjectContext) {
        self.vm = SearchHistoryViewModel(context: context)
    }
    
    var body: some View {
        VStack {
            if vm.searchHistories.isEmpty {
                ContentUnavailableView("There is no Search History yet", systemImage: "exclamationmark.arrow.circlepath")
            } else {
                List {
                    ForEach(vm.searchHistories) { searchHistory in
                        DisclosureGroup {
                            if vm.searchHistories.isEmpty {
                                ContentUnavailableView("No Article for this Search History", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
                            }
                            else {
                                MiniArticleListView(articles: searchHistory.articles)
                                    .environmentObject(vm)
                            }
                        } label: {
                            Text(searchHistory.searchText)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        vm.deleteSearchHistory(byIndex: indexSet.toInt())
                    })
                }
                .sheet(isPresented: $vm.sheetIsPresented, content: {
                    DetailView(vm: DetailViewModel(article: vm.selectedArticle))
                })
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: vm.searchHistories)
                .alert("Delete all Search History", isPresented: $vm.alertIsPresented) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete All", role: .destructive) {
                        vm.deleteAllSearchHistory()
                    }
                } message: {
                    Text("Are you sure you want to delete all search history?")
                }

            }
        }
        .navigationTitle("Search History")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.alertIsPresented.toggle()
                }, label: {
                    Image(systemName: "trash")
                })
                .tint(.red)
            }
        }
        .task {
            vm.loadSearchHistory()
        }
    }
}

//#Preview {
//    SearchHistoryView(context: moc)
//}
