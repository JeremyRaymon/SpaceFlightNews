//
//  SearchHistoryView.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

struct SearchHistoryView: View {
    @StateObject var vm = SearchHistoryViewModel()
    @State var toggle = false
    
    var body: some View {
        VStack {
            List($vm.searchHistories, id:\.self) { $searchHistory in
                DisclosureGroup {
                    ForEach(Array(searchHistory.articleentity as! Set<ArticleEntity>), id:\.self) { article in
                        Text(article.title ?? "")
                    }
                } label: {
                    Text(searchHistory.searchText ?? "")
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
        }
        .task {
            vm.loadSearchHistory()
        }
    }
}

#Preview {
    SearchHistoryView()
}
