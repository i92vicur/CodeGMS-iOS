import SwiftUI
import SwiftData

struct AllGamesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]
    @StateObject var viewModel = AllGamesViewModel()
    @State private var searchText: String = ""
    @State private var selectedSortOption: SortOption = .alphabetical // Default sort option
    
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
            
            // Sort Options Dropdown
            Menu {
                Button("Alphabetical") {
                    selectedSortOption = .alphabetical
                    sortGames()
                }
                Button("Most Recent") {
                    selectedSortOption = .mostRecent
                    sortGames()
                }
                Button("Oldest") {
                    selectedSortOption = .oldest
                    sortGames()
                }
            } label: {
                Label("Sort By", systemImage: "arrow.up.arrow.down")
                    .font(.headline)
            }
            .padding(.horizontal, 15)
            
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.games.isEmpty {
                
                // Games List
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
                        // Pagination
                        if let nextPage = viewModel.nextPage,
                           let lastGame = viewModel.games.last,
                           let lastGameId = Int(lastGame.slug.components(separatedBy: "-").last ?? ""),
                           lastGameId == viewModel.games.last?.id {
                            viewModel.loadGames()
                        }
                    }
                }
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                Text("No games available.")
            }
        }
    }
    
    private func filterGames() {
        if searchText.isEmpty {
            viewModel.loadGames() 
        } else {
            viewModel.games = viewModel.games.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
   
    private func sortGames() {
        switch selectedSortOption {
        case .alphabetical:
            viewModel.games.sort { (game1: Game, game2: Game) -> Bool in
                return game1.name < game2.name
            }
        case .mostRecent:
            viewModel.games.sort { (game1: Game, game2: Game) -> Bool in
                return game1.released > game2.released
            }
        case .oldest:
            viewModel.games.sort { (game1: Game, game2: Game) -> Bool in
                return game1.released < game2.released
            }
        }
    }
}

struct AllGamesView_Previews: PreviewProvider {
    static var previews: some View {
        AllGamesView()
            .modelContainer(for: Favorite.self, inMemory: true)
    }
}

enum SortOption {
    case alphabetical
    case mostRecent
    case oldest
}
