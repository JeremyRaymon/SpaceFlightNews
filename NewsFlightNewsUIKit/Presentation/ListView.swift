//
//  ListView.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import SwiftUI

struct ListView: View {
    @State var searchHistories: [String]
    
    var body: some View {
        List {
            ForEach(searchHistories, id:\.self) { searchHistory in
                Text(searchHistory)
            }
            .onDelete(perform: { indexSet in
                PersistentManager.shared.deleteSearchHistory(index: indexSet)
            })
        }
    }
    
    func reloadData(searchHistories: [String]) {
        self.searchHistories = searchHistories
    }
}

#Preview {
    ListView(searchHistories: [])
}
