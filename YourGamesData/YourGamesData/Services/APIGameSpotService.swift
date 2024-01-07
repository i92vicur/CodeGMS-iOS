import Foundation

class APIGameSpotService {
    func getNews() async throws -> [News] {
        let urlString = "http://www.gamespot.com/api/articles/?api_key=\(apiKeyGameSpot)&format=json&sort=publish_date:desc"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let newsList = try decoder.decode(NewsList.self, from: data)
        
        return newsList.results
    }
}
