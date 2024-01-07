import Foundation

class APIRAWGService {
    func getGames(page: Int = 1) async throws -> GamesList {
        let pageSize = 40
        let urlString = "https://api.rawg.io/api/games?key=\(apiKeyRAWG)&dates=2000-09-01,2023-12-31&page_size=\(pageSize)&page=\(page)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(GamesList.self, from: data)
    }
}
