//
//  NewsDetailView.swift
//  YourGamesData
//
//  Created by Luis Enrique Rosas Espinoza on 04/01/24.
//

import SwiftUI

struct NewsDetailView: View {
    let news: News
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageURL = URL(string: news.image.original) {
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
                        
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                        
                }
                Text(news.title)
                    .font(.title)
                    .padding(.bottom)
                Text(news.deck)
                    .font(.body)
                    .padding(.bottom)
                
                Text(news.body)
                    .font(.body)
                    .padding(.bottom)
                Text(news.lede)
                    .font(.body)
                    .padding(.bottom)
                
                Text("Publish Date: \(news.publishDate)")
                    .font(.body)
                    .padding(.bottom)
                Text("Update Date: \(news.updateDate)")
                    .font(.body)
                    .padding(.bottom)
                Text("Site Detail URL: \(news.siteDetailURL)")
                    .font(.body)
                    .padding(.bottom)
                Text("Authors: \(news.authors)")
                    .font(.body)
                    .padding(.bottom)
            }
            .padding()
        }
    }
}
