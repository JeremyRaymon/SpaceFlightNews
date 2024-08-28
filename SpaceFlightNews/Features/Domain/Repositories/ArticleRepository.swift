//
//  ArticleRepository.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 28/08/24.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func fetchArticles(offset: Int ) async throws -> [Article]
    func fetchNewsSites() async throws -> [String]
    func downloadImage(url: String) async throws -> Data
}

struct ArticleRepository: ArticleRepositoryProtocol {
    let networkService: NetworkService
    
    func fetchArticles(offset: Int = 0) async throws -> [Article] {
        try await networkService.fetchArticles(offset: offset)
    }
    
    func fetchNewsSites() async throws -> [String] {
        try await networkService.fetchNewsSites()
    }
    
    func downloadImage(url: String) async throws -> Data {
        try await networkService.downloadImage(url: url)
    }
}
