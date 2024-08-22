//
//  SpaceFlightNewsApp.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import SwiftUI

@main
struct SpaceFlightNewsApp: App {
    @StateObject private var coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ArticleListView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
