//
//  HeadlinesView.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import SwiftUI

struct HeadlinesView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var selectedCategory: String = ""
    let categories: [String] = ["general", "technology", "business", "entertainment", "health", "science", "sports"]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self){ category in
                            Text(category.capitalized)
                                .font(.headline)
                                .foregroundStyle(selectedCategory == category ? .red : .white)
                                .frame(width: 150, height: 40)
                                .background(selectedCategory == category ? .white : .red)
                                .cornerRadius(10)
                                .shadow(radius: 10, x: 0, y: 4)
                                .onTapGesture {
                                    selectedCategory = category
                                    viewModel.fetchArticles(for: category)
                                }
                        }
                    }
                    .padding(8)
                }
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ArticleListView(articles: viewModel.articles)
                }
                
                Spacer()
                
            }
            .navigationTitle("Headlines")
            .onAppear {
                Task {
                    await viewModel.fetchDefaultNews()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Menu {
                        Button {
                            viewModel.toggleSortOrder()
                        } label: {
                            HStack {
                                Text(viewModel.isSortedByNewest ? "Oldest First" : "Newest First")
                                Image(systemName: viewModel.isSortedByNewest ? "arrow.down" : "arrow.up")
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        }
        .tint(.red)
    }
}

#Preview {
    HeadlinesView()
        .environmentObject(NewsViewModel())
}
