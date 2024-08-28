//
//  IndexSet+Ext.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 21/08/24.
//

import Foundation

extension IndexSet {
    func toInt() -> Int {
        self.first! as Int
    }
}
