//
//  ArticleCollectionViewCell.swift
//  NewsFlightNewsUIKit
//
//  Created by Jeremy Raymond on 20/07/24.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    static let reuseID = "Article Cell"
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .tertiaryLabel
        self.layer.cornerRadius = 12
        configureImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        titleLabel.text = article.title
        Task {
            let image = UIImage(data: try await NetworkManager.shared.downloadImage(imageUrl: article.imageUrl))
            imageView.image = image
        }
    }
    
    func configureImageView() {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
        ])
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.alignAtBottom(of: imageView)
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
        ])
    }
}
