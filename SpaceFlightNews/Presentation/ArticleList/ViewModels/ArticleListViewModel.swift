//
//  ArticleListViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation

class ArticleListViewModel: ObservableObject {
    @Published var searchString = ""
    @Published var selectedNewsSite = "All"
    @Published var articles: [Article] = []
    @Published var newsSites: [String] = []
    
    var filteredArticles: [Article] {
        var filteredArticles = articles
        if !searchString.isEmpty {
            filteredArticles = filteredArticles.filter{ $0.title.localizedStandardContains(searchString)}
        }
        if selectedNewsSite != "All" {
            filteredArticles = filteredArticles.filter{$0.newsSite.elementsEqual(selectedNewsSite) }
        }
        return filteredArticles
    }
}
