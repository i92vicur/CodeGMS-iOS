//
//  APIRAWGService.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 04/01/24.
//

import Foundation

class APIRAWGService {
    func getGames(page: Int = 1) async throws -> GamesList {
        let pageSize = 80
        let urlString = "https://api.rawg.io/api/games?key=\(apiKeyRAWG)&dates=2020-09-01,2023-12-31&platforms=18,1,7&page_size=\(pageSize)&page=\(page)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(GamesList.self, from: data)
    }
}

