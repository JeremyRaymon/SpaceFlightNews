//
//  NetworkServices.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 14/08/24.
//

import Foundation

protocol NetworkService {
    func fetchArticles(offset: Int) async throws -> [Article]
    func fetchNewsSites() async throws -> [String]
    func downloadImage(url: String) async throws -> Data
}
