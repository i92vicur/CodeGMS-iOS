import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let newsList = viewModel.newsList {
                // Aquí puedes mostrar la lista de noticias
                List(newsList, id: \.id) { news in
                    // Card para mostrar la noticia con su imagen
                    NavigationLink(destination: NewsDetailView(news: news)) {
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: news.image.original)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 200)
                            .cornerRadius(10)
                            
                            HStack {
                                Text("Date: \(news.publishDate)")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            Text(news.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                
                            
                            Text(news.deck)
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                    }
                    
                }
            } else if let error = viewModel.error {
                // Mostrar un mensaje de error
                Text("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
}

#Preview {
    NewsView()
}
