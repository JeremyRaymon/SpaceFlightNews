//
//  SearchHistoryViewController.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import UIKit
import SwiftUI

class SearchHistoryViewController: UIViewController {
    var searchHistories: [String] = []
    var listView = UIHostingController(rootView: ListView(searchHistories: []))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search History"
        // Do any additional setup after loading the view.
        self.searchHistories = PersistentManager.shared.fetchSearchHistories()
        configureSwiftUIList()
        configureDeleteAllButton()
    }
    
    func configureSwiftUIList() {
        listView = UIHostingController(rootView: ListView(searchHistories: self.searchHistories))
        
        self.addChild(listView)
        view.addSubview(listView.view)
        
        listView.view.setConstraintToEdges(of: view)
        
    }

    func configureDeleteAllButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .trash, primaryAction: UIAction(handler: { action in
            PersistentManager.shared.deleteAllSearchHistory()
            self.searchHistories.removeAll()
        }))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
}
