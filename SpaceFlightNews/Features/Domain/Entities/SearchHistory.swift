//
//  SearchHistory.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import Foundation

struct SearchHistory: Identifiable, Equatable, Hashable {
    let id = UUID()
    let searchText: String
    let articles: [Article]
}
