import SwiftData

@Model
class Favorite {
    @Attribute(.unique) let id: Int
    let name: String
    let backgroundImage: String
    var price: Double? 
    var format: GameFormat?
    
    enum GameFormat: String, Codable {
        case physical
        case digital
    }

    init(id: Int, name: String, backgroundImage: String) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
    }
}
