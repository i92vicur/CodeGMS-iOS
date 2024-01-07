
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {

                HStack {
                    Text("Cole")
                        .foregroundColor(.red)
                    
                    Text("GMS")
                        .foregroundColor(.gray)
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)
                .padding(.bottom, 10)
                
                TabView {
                    Group {
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
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}

