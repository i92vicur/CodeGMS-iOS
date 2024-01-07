//
//  NewsViewModel.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 04/01/24.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var newsList: [News]?
    @Published var isLoading = false
    @Published var error: Error?
    
    init() {
        loadNews()
    }
    
    func loadNews() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        Task {
            do {
                let loadedNews = try await APIGameSpotService().getNews()
                DispatchQueue.main.async {
                    self.newsList = loadedNews
                    self.isLoading = false
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
