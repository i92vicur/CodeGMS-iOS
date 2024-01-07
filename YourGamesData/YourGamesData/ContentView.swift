//
//  ContentView.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 03/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                Group  {                
                    NewsView()
                        .tabItem {
                            Label("News", systemImage: "newspaper")
                        }
                
                    AllGamesView()
                        .tabItem {
                            Label("All Games", systemImage: "gamecontroller")
                        }
                
                    GamesCollectionView()
                        .tabItem {
                            Label("Collection", systemImage: "folder.badge.plus")
                        }
                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .accentColor(.red)
            .navigationTitle("ColeGMS")
        }
    }
}

#Preview {
    ContentView()
}

