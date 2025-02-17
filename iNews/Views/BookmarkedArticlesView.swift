//
//  BookmarkedArticlesView.swift
//  iNews
//
//  Created by Tanmay . on 17/02/25.
//

import SwiftUI

struct BookmarkedArticlesView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.bookmarkedArticles.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "bookmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                        
                        Text("No Bookmarked Articles yet.")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        
                        Text("Articles you bookmark will appear here.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                } else {
                    ArticleListView(articles: viewModel
                        .bookmarkedArticles)
                }
            }
            .navigationTitle("Bookmarked")
           
        }
        .tint(.red)
        
        
    }
}

#Preview {
    BookmarkedArticlesView()
        .environmentObject(NewsViewModel())
}
