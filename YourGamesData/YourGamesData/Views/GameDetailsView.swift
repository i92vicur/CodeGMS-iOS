import SwiftUI
import SwiftData

struct GameDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]

    let game: Game
    @State private var selectedScreenshot: String?

    var body: some View {
        ScrollView {
            // Display cover image
            AsyncImage(url: URL(string: game.backgroundImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                // Game title
                Text(game.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                .padding()

                // Release date
                InfoRow(title: "Release date", value: game.released)

                // Metacritic score
                InfoRow(title: "Metacritic score", value: "\(game.metacritic ?? 0)")
                
                // Rating
                InfoRow(title: "Rating", value: "\(game.rating)")

                // Playtime
                InfoRow(title: "Playtime", value: "\(game.playtime)")

                // Genres
                InfoRow(title: "Genres", value: game.genres.map { $0.name }.joined(separator: "\n"))

                // Platforms
                InfoRow(title: "Platforms", value: game.platforms.map { $0.platform.name }.joined(separator: "\n"))

                // Stores
                InfoRow(title: "Stores", value: game.stores.map { $0.store.name }.joined(separator: "\n"))

                // Screenshots section
                VStack(alignment: .leading) {
                    Text("Screenshots")
                        .font(.headline)
                        .fontWeight(.bold)

                    // Display screenshots
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                        ForEach(game.shortScreenshots, id: \.id) { screenshot in
                            Button {
                                selectedScreenshot = screenshot.image
                            } label: {
                                AsyncImage(url: URL(string: screenshot.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 100)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 100)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .overlay(
            //Show zoomed screenshot
            Group {
                if let screenshot = selectedScreenshot {
                    ImageFullScreenView(imageURL: screenshot) {
                        // Cerrar la vista de pantalla completa al tocar fuera de la imagen
                        selectedScreenshot = nil
                    }
                }
            }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if favorites.contains(where: { $0.id == game.id }) {
                        removeFromFavorites(game: game, modelContext: modelContext)
                    } else {
                        addToFavorites(game: game, modelContext: modelContext)
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

    func addToFavorites(game: Game, modelContext: ModelContext) {
        let favorite = Favorite(id: game.id, name: game.name, backgroundImage: game.backgroundImage)
        modelContext.insert(favorite)
    }

    func removeFromFavorites(game: Game, modelContext: ModelContext) {
        if let favorite = favorites.first(where: { $0.id == game.id }) {
            modelContext.delete(favorite)
        }
    }
}

struct ImageFullScreenView: View {
    let imageURL: String
    let onTap: () -> Void

    var body: some View {
        ZStack {

            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .gesture(TapGesture().onEnded {
                        onTap()
                    })
            } placeholder: {
                ProgressView()
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

struct InfoRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Spacer()

            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 10)
    }
}
