//
//  GameDetailsView.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 03/01/24.
//

import SwiftUI
import SwiftData

struct GameDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]
    
    let game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.title)
                    .padding(.bottom, 10)
                Text("Release date: \(game.released)")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Metacritic score: \(game.metacritic ?? 0)")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Rating: \(game.rating)")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Playtime: \(game.playtime)")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Genres: \(game.genres.map { $0.name }.joined(separator: ", "))")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Platforms: \(game.platforms.map { $0.platform.name }.joined(separator: ", "))")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Tags: \(game.tags.map { $0.name }.joined(separator: ", "))")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Stores: \(game.stores.map { $0.store.name }.joined(separator: ", "))")
                    .font(.body)
                    .padding(.bottom, 10)
                Text("Screenshots: \(game.shortScreenshots.map { $0.image }.joined(separator: ", "))")
                    .font(.body)
                    .padding(.bottom, 10)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if favorites.contains(where: { $0.id == game.id }) {
                        removeFromFavorites(game: game, modelContext: modelContext)
                    } else {
                        addTofavorites(game: game, modelContext: modelContext)
                    }
                } label: {
                    if favorites.contains(where: { $0.id == game.id }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .padding(.trailing)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                }
            }
        }
    }
    
    func addTofavorites(game: Game, modelContext: ModelContext) {
        let favorite = Favorite(id: game.id, name: game.name, backgroundImage: game.backgroundImage)
        modelContext.insert(favorite)
    }
    
    func removeFromFavorites(game: Game, modelContext: ModelContext) {
        if let favorite = favorites.first(where: { $0.id == game.id }) {
            modelContext.delete(favorite)
        }
    }
}
