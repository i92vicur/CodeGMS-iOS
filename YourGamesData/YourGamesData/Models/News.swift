
import Foundation

// MARK: - NewsList
struct NewsList: Codable {
    let error: String
    let limit, offset, numberOfPageResults, numberOfTotalResults: Int
    let statusCode: Int
    let results: [News]
    let version: String

    enum CodingKeys: String, CodingKey {
        case error, limit, offset
        case numberOfPageResults = "number_of_page_results"
        case numberOfTotalResults = "number_of_total_results"
        case statusCode = "status_code"
        case results, version
    }
}

// MARK: - Result
struct News: Codable {
    let publishDate, updateDate: String
    let id: Int
    let authors, title: String
    let image: ImageNews
    let deck, body, lede: String
    let categories: [Category]
    let associations: [Association]
    let siteDetailURL: String
    let videosAPIURL: String?

    enum CodingKeys: String, CodingKey {
        case publishDate = "publish_date"
        case updateDate = "update_date"
        case id, authors, title, image, deck, body, lede, categories, associations
        case siteDetailURL = "site_detail_url"
        case videosAPIURL = "videos_api_url"
    }
}

// MARK: - Association
struct Association: Codable {
    let id: Int
    let name: String
    let apiDetailURL: String?
    let guid: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case apiDetailURL = "api_detail_url"
        case guid
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case deals = "Deals"
    case features = "Features"
    case film = "Film"
    case games = "Games"
    case guides = "Guides"
    case news = "News"
    case opinion = "Opinion"
    case preview = "Preview"
    case standardFeature = "Standard Feature"
    case standardNews = "Standard News"
    case tabletop = "Tabletop"
    case tech = "Tech"
    case tv = "TV"
}

// MARK: - Image
struct ImageNews: Codable {
    let squareTiny, screenTiny, squareSmall, original: String

    enum CodingKeys: String, CodingKey {
        case squareTiny = "square_tiny"
        case screenTiny = "screen_tiny"
        case squareSmall = "square_small"
        case original
    }
}
