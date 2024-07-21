//
//  String+Ext.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import Foundation

extension String {
    func shortedToDot() -> String {
        let shortenedString = self
        guard let dotIndex = shortenedString.firstIndex(where: {$0 == "."}) else {
            return shortenedString
        }
        let index = shortenedString.distance(from: shortenedString.startIndex, to: dotIndex)
        return String(self.prefix(index) + ".")
    }
}
