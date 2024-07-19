//
//  SearchHistoryView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct SearchHistoryView: View {
    @StateObject var vm = SearchHistoryViewModel()
    
    var body: some View {
        VStack {
            if vm.searchHistories.isEmpty {
                ContentUnavailableView("There is no Search History yet", systemImage: "exclamationmark.arrow.circlepath")
            } else {
                List {
                    ForEach($vm.searchHistories, id:\.self) { $searchHistory in
                        DisclosureGroup {
                            if vm.getArticleArray(searchHistory: searchHistory).isEmpty {
                                ContentUnavailableView("No Article for this Search History", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
                            }
                            else {
                                ForEach(vm.getArticleArray(searchHistory: searchHistory), id:\.self) { article in
                                    Text(article.title ?? "")
                                }
                            }
                        } label: {
                            Text(searchHistory.searchText ?? "")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        vm.deleteSearchHistory(indexSet: indexSet)
                    })
                }
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
//                    Text("Delete All")
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

#Preview {
    SearchHistoryView()
}
