//
//  AllGamesView.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 03/01/24.
//

import SwiftUI
import SwiftData

struct AllGamesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]
    @StateObject var viewModel = AllGamesViewModel()
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search", text: $searchText)
                .padding(8)
                .cornerRadius(8)
                .padding(.horizontal, 15)
                .onChange(of: searchText) { _ in
                    filterGames()
                }

            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.games.isEmpty {
                // Mostrar la lista de juegos
                List {
                    ForEach(viewModel.games, id: \.id) { game in
                        // Card para mostrar los juegos
                        HStack {
                            if favorites.contains(where: { $0.id == game.id }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                            } else {
                                Image(systemName: "heart")
                                    .foregroundColor(.red)
                                    .padding(.trailing)
                            }

                            NavigationLink(destination: GameDetailsView(game: game)) {
                                HStack {
                                    AsyncImage(url: URL(string: game.backgroundImage)!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)

                                    VStack(alignment: .leading) {
                                        Text(game.name)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)

                                        Text(game.released)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        // Cargar más juegos cuando llegamos al final de la lista
                        if let nextPage = viewModel.nextPage,
                        let lastGame = viewModel.games.last,
                        let lastGameId = Int(lastGame.slug.components(separatedBy: "-").last ?? ""),
                        lastGameId == viewModel.games.last?.id {
                            viewModel.loadGames()
                        }
                    }
                }
            } else if let error = viewModel.error {
                // Mostrar un mensaje de error
                Text("Error: \(error.localizedDescription)")
            } else {
                // Mensaje para cuando no hay juegos
                Text("No games available.")
            }
        }
    }

    private func filterGames() {
        if searchText.isEmpty {
            viewModel.loadGames() // Cargar todos los juegos nuevamente
        } else {
            viewModel.games = viewModel.games.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct AllGamesView_Previews: PreviewProvider {
    static var previews: some View {
        AllGamesView()
            .modelContainer(for: Favorite.self, inMemory: true)
    }
}


#Preview {
    AllGamesView()
        .modelContainer(for: Favorite.self, inMemory: true)
}
