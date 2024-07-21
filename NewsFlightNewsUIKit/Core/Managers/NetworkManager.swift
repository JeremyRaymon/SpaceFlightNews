//
//  NetworkManager.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation
import Combine

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL from the server. Please try again."
    case invalidResponse = "Invalid Response from the server. Please try again."
    case invalidData = "Invalid Data from the server. Please try again."
}

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let baseURL = "https://api.spaceflightnewsapi.net/v4/"
        
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func fetchArticles(offset: Int = 0) async throws -> [Article] {
        let endpoint = baseURL + "articles/?limit=10&offset=\(offset)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let articlesWrapper = try decoder.decode(ArticlesWrapper.self, from: data)
            return articlesWrapper.results
        } catch {
            throw NetworkError.invalidData
        }
    }
        
    func fetchNewsSites() async throws -> [String] {
        let endpoint = baseURL + "info/"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let newsSites = try decoder.decode(NewsSitesWrapper.self, from: data)
            return newsSites.newsSites
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func downloadImage(imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidData
        }
        
        return data
    }
}
