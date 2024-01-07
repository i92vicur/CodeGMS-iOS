
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
                    .padding(.top, 10)
                }
                .padding(.top, 10)
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

