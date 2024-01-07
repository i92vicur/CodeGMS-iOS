//
//  YourGamesDataApp.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 03/01/24.
//

import SwiftUI
import SwiftData

let apiKeyRAWG = "d4aa85f8e19d44d79553477b4727098e"
let apiKeyGameSpot = "c318e74ac57624330567d614a73d512fdd835331"

@main
struct YourGamesDataApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Favorite.self])
    }
}
