//
//  ArticleUseCases.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 28/08/24.
//

import Foundation

protocol ArticleUseCasesProtocol {
    func fetchArticles(offset: Int) async throws -> [Article]
    func fetchNewsSites() async throws -> [String]
    func downloadImage(url: String) async throws -> Data
}

struct ArticleUseCases: ArticleUseCasesProtocol {
    private let articleRepository: ArticleRepository
    
    init(articleRepository: ArticleRepository) {
        self.articleRepository = articleRepository
    }
    
    func fetchArticles(offset: Int) async throws -> [Article] {
        try await articleRepository.fetchArticles(offset: offset)
    }
    
    func fetchNewsSites() async throws -> [String] {
        try await articleRepository.fetchNewsSites()
    }
    
    func downloadImage(url: String) async throws -> Data {
        try await articleRepository.downloadImage(url: url)
    }
    
   
    
    
}
