//
//  ArticleListViewController.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import UIKit

class ArticleListViewController: UIViewController {
    enum Section {
        case main
    }
    var articles: [Article] = []
    var filteredArticles: [Article] = []
    var newssites: [String] = []
    var selectedNewsSite: String = ""
    var offset = 10
    
    var newssiteMenu: NewsSiteMenu!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Article>!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureToolBar()
        self.title = "Articles"

        Task {
            try await configureNewsSiteMenu()
            try await configureCollection()
        }
    }
    
    func configureNewsSiteMenu() async throws {
        self.newssites = try await NetworkManager.shared.fetchNewsSites()
        self.newssites.insert("All", at: 0)
        self.selectedNewsSite = self.newssites.first ?? "All"
        self.configureMenuView(newssites: self.newssites)
    }
    
    func configureCollection() async throws {
        articles = try await NetworkManager.shared.fetchArticles()
        filteredArticles = articles
        configureCollectionView()
        configureDataSource()
        applySnapshot(articles: articles)
    }
    
    func configureToolBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "clock.arrow.circlepath"), primaryAction: UIAction(handler: { action in
            self.navigationController?.pushViewController(SearchHistoryViewController(), animated: true)
        }))
        
    }
    
    func configureSearchBar() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search title..."
        navigationItem.searchController = searchController
    }
    
    func configureMenuView(newssites: [String]) {
        newssiteMenu = NewsSiteMenu(newssites: newssites)
        view.addSubview(newssiteMenu)
        
        newssiteMenu.delegate = self
            
        newssiteMenu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newssiteMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newssiteMenu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newssiteMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ])
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width-24, height: view.bounds.height/4)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 24, left: 48, bottom: 24, right: 48)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: newssiteMenu.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.reuseID, for: indexPath) as? ArticleCollectionViewCell else {
                fatalError("Cannot create a new cell")
            }
            cell.set(article: self.articles[indexPath.item])
            return cell
        })
        collectionView.dataSource = dataSource
    }
    
    func applySnapshot(articles: [Article]) {
        guard let dataSource = dataSource else {
            print("Error: dataSource is nil")
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ArticleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ArticleDetailViewController(article: articles[indexPath.item]), animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            print("End of line")
            Task {
                self.articles.append(contentsOf: try await NetworkManager.shared.fetchArticles(offset: self.offset))
                offset+=10
                self.changeNewsSite(selectedNewsSite: self.selectedNewsSite)
                applySnapshot(articles: filteredArticles)
            }
            
//            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
//            page += 1
//            getFollowers(username: username, page: page)
        }
    }
}

extension ArticleListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredArticles.removeAll()
            applySnapshot(articles: articles)
            return
        }
        
        filteredArticles = articles.filter({ $0.title.lowercased().contains(filter.lowercased()) })
        applySnapshot(articles: filteredArticles)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("done")
        PersistentManager.shared.addSearchHistory(searchHistory: searchBar.text ?? "")
    }
}

extension ArticleListViewController: UINewsSiteMenuDelegate {
    func changeNewsSite(selectedNewsSite: String) {
        self.selectedNewsSite = selectedNewsSite
        
        if selectedNewsSite == "All" {
            filteredArticles = articles
        } else {
            filteredArticles = articles.filter(
                {$0.newsSite.lowercased().contains(selectedNewsSite.lowercased())}
            )
        }
        applySnapshot(articles: filteredArticles)
}
    

    
    
}

#Preview {
    ArticleListViewController()
}
