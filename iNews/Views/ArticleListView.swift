//
//  ArticleListView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ArticleListView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
            
            List {
//                    HStack {
//                        if viewModel.searchQuery.isEmpty {
//                            Text("Headlines")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundStyle(.red)
//                                .shadow(radius: 5, x: 0, y: 4)
//                                .padding(.vertical, 8)
//                           
//                        } else {
//                            Text("\(viewModel.searchQuery.capitalized)")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundStyle(.red)
//                                .shadow(radius: 5, x: 0, y: 4)
//                                .padding(.vertical, 8)
//                        }
//                        Spacer()
//                    }
               
                ForEach(articles) { article in
                    ArticleRowView(article: article)
                        .onTapGesture {
                            selectedArticle = article
                        }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .sheet(item: $selectedArticle) {
                SafariView(url: $0.articleURL)
                    .ignoresSafeArea(edges: .bottom)
            }
    }
}

#Preview {
    ArticleListView(articles: Article.previewData)
        .environmentObject(NewsViewModel())
}
