import SwiftUI
import SwiftData

struct GamesCollectionView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var favorites: [Favorite]
    @State private var searchText: String = ""
    @State private var selectedFavorite: Favorite?
    @State private var editedPrice: String = ""
    @State private var selectedFormat: Favorite.GameFormat = .physical
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search", text: $searchText)
                    .padding(8)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .onChange(of: searchText) { _ in
                        filterFavorites()
                    }

                // Total Games Text
                Text("Total games: \(favorites.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)

                List {
                    ForEach(filteredFavorites) { favorite in
                        HStack {
                            AsyncImage(url: URL(string: favorite.backgroundImage)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)

                            VStack(alignment: .leading) {
                                Text(favorite.name)
                                if selectedFavorite == favorite {
                                    TextField("Price", text: $editedPrice)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    
                                    Picker("Edition", selection: $selectedFormat) {
                                        Text("Physical").tag(Favorite.GameFormat.physical)
                                        Text("Digital").tag(Favorite.GameFormat.digital)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                } else {
                                    Text("Price: \(favorite.price != nil ? "$\(favorite.price!)" : "N/A")")
                                        .foregroundColor(.secondary)
                                    Text("Format: \(favorite.format?.rawValue.capitalized ?? "N/A")")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onTapGesture {
                                if selectedFavorite != favorite {
                                    selectedFavorite = favorite
                                    editedPrice = favorite.price.flatMap { String($0) } ?? ""
                                    selectedFormat = favorite.format ?? .physical
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }

    private var filteredFavorites: [Favorite] {
        if searchText.isEmpty {
            return favorites
        } else {
            return favorites.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    private func filterFavorites() {
        // Implementa la lógica de filtrado si es necesario
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                do {
                    modelContext.delete(favorites[index])
                    try modelContext.save()
                } catch {
                    print("Error deleting favorite: \(error)")
                    // Handle the error appropriately (e.g., show an alert)
                }
            }
        }
    }
}
