//
//  ArticleDetailViewController.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    let article: Article
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var newssiteLabel = UILabel()
    var publishedAtLabel = UILabel()
    var summaryLabel = UITextView()
    var linkButton = UIButton()
    
    init(article: Article) {
        self.article = article
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImageView()
        configureTitleLabel()
        configureNewsSiteLabel()
        configurePublishedAtLabel()
        configureSummaryLabel()
        configureLinkButton()
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        
        Task {
            let image = UIImage(data: try await NetworkManager.shared.downloadImage(imageUrl: article.imageUrl))
            imageView.image = image
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12),
        ])
    }
    

    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = article.title
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 3
        
        titleLabel.alignAtBottom(of: imageView)
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        ])
    }
    
    func configureNewsSiteLabel() {
        view.addSubview(newssiteLabel)
        
        newssiteLabel.text = article.newsSite
        newssiteLabel.font = .preferredFont(forTextStyle: .headline)
        newssiteLabel.numberOfLines = 1
        
        newssiteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newssiteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            newssiteLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }
    
    func configurePublishedAtLabel() {
        view.addSubview(publishedAtLabel)
        
        publishedAtLabel.text = article.publishedAt.convertToLongDateTimeFormat()
        publishedAtLabel.font = .preferredFont(forTextStyle: .body)
        publishedAtLabel.numberOfLines = 1
        
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publishedAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            publishedAtLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    func configureSummaryLabel() {
        view.addSubview(summaryLabel)
        
        summaryLabel.text = article.summary.shortedToDot()
        summaryLabel.font = .preferredFont(forTextStyle: .body)
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 12),
            summaryLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            summaryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12),
            summaryLabel.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureLinkButton() {
        view.addSubview(linkButton)
        
        linkButton.setImage(UIImage(systemName: "link"), for: .normal)
        linkButton.setTitle("Original Article", for: .normal)
        linkButton.tintColor = .systemIndigo
        linkButton.setTitleColor(.systemIndigo, for: .normal)
        
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 12),
            linkButton.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor)
        ])
        
        linkButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
    }
    
    @objc func openLink() {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
}
