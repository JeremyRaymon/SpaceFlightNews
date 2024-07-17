//
//  NetworkManager.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 17/07/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    let decoder = JSONDecoder()
    let baseURL = "https://api.spaceflightnewsapi.net/v4/"
    
    func fetchArticles() async throws -> [Article] {
        let endpoint = baseURL + "articles/"
        
        guard let url = URL(string: endpoint) else {
            throw NSError(domain: "Bad URL", code: 400)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NSError(domain: "Bad Response", code: 400)
        }
        
        do {
            let articlesWrapper = try decoder.decode(ArticlesWrapper.self, from: data)
            return articlesWrapper.results
        } catch {
            throw NSError(domain: "Bad Data", code: 400)
        }
    }
}
