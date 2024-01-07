//
//  GamesCollectionView.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 03/01/24.
//

import SwiftUI
import SwiftData

struct GamesCollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Favorite]
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
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
                            Text(favorite.name)
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
        } detail: {
            Text("Select an item")
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
        // Implementar lógica de filtrado aquí si es necesario
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favorites[index])
            }
        }
    }
}

#Preview {
    GamesCollectionView()
        .modelContainer(for: Favorite.self, inMemory: true)
}
