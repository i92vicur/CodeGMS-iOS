//
//  Favorite.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 04/01/24.
//

import SwiftData

@Model
class Favorite {
    @Attribute(.unique) let id: Int
    let name: String
    let backgroundImage: String
    
    init(id: Int, name: String, backgroundImage: String) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
    }
}
