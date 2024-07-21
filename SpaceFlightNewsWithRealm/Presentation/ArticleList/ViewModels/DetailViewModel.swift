//
//  DetailViewModel.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/07/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    let article: Article
    
    var shortenedSummary: String {
        let sum = article.summary
        guard let dotIndex = sum.firstIndex(where: {$0 == "."}) else {
            return sum
        }
        let index = sum.distance(from: sum.startIndex, to: dotIndex)
        return String(article.summary.prefix(index) + ".")
    }
    
    init(article: Article) {
        self.article = article
    }
}
