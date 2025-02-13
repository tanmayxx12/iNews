//
//  ArticleListView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationStack {
            List {
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
}

#Preview {
    ArticleListView(articles: Article.previewData)
}
