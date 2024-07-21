//
//  Date+Ext.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation

extension Date {
    func convertToLongDateTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}
