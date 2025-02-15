//
//  HeadlinesView.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import SwiftUI

struct HeadlinesView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    let categories: [String] = ["general", "technology", "business", "entertainment", "health", "science", "sports"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Headlines")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories, id: \.self) { category in
                                Button {
                                    viewModel.fetchArticles(for: category)
                                } label: {
                                    Text(category.capitalized)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .frame(width: 150, height: 40)
                                        .background(.red)
                                        .cornerRadius(10)
                                        .shadow(radius: 5, x: 0, y: 4)
                                }
                            }
                        }
                        .padding(8)
                    }
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    LazyVStack {
                        ForEach(viewModel.articles) { article in
                            ArticleRowView(article: article)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("News")
            .ignoresSafeArea(edges: .bottom)
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
        }
        .tint(.red)
    }
}

#Preview {
    HeadlinesView()
        .environmentObject(NewsViewModel())
}
