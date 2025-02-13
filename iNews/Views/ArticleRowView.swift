//
//  ArticleRowView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ArticleRowView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    let news: NewsResponse
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: news.articles.first?.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.horizontal)
                    
                    
                    Text("\(viewModel.news?.articles.first?.title ?? "")")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(viewModel.news?.articles.first?.descriptionText ?? "")")
                        .font(.subheadline)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
       
        
    }
}

#Preview {
            ArticleRowView(news: DeveloperPreview.instance.previewData)
        .environmentObject(NewsViewModel(isPreview: true))
}
