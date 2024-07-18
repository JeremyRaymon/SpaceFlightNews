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
            Group {
                if vm.searchHistories.isEmpty {
                    ContentUnavailableView("There is no Search History yet", systemImage: "exclamationmark.arrow.circlepath")
                } else {
                    List {
                        ForEach($vm.searchHistories, id:\.self) { $searchHistory in
                            DisclosureGroup {
                                ForEach(Array(searchHistory.articleentity as! Set<ArticleEntity>), id:\.self) { article in
                                    Text(article.title ?? "")
                                }
                            } label: {
                                Text(searchHistory.searchText ?? "")
                            }
                        }
                        .onDelete(perform: { indexSet in
                            vm.deleteSearchHistory(indexSet: indexSet)
                        })
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.deleteAllSearchHistory()
                }, label: {
                    Text("Delete All")
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
