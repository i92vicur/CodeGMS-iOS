//
//  AllGamesViewModel.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 04/01/24.
//

import SwiftUI
import SwiftData

class AllGamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedGame: Game?
    @Published var showSheet = false
    @Published var nextPage: String? // Variable para almacenar la URL de la próxima página

    private var currentPage = 1

    init() {
        loadGames()
    }

    func loadGames() {
        guard !isLoading else { return } // Evitar cargar si ya está en progreso
        isLoading = true

        Task {
            do {
                let loadedGames = try await APIRAWGService().getGames(page: currentPage)
                DispatchQueue.main.async {
                    self.games.append(contentsOf: loadedGames.results)
                    self.nextPage = loadedGames.next
                    self.isLoading = false
                    self.currentPage += 1
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
}
