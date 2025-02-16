//
//  ContentView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var searchText: String = ""

    
    var body: some View {
        NavigationStack {
            VStack {
                if searchText.isEmpty && !viewModel.searchHistory.isEmpty {
                    // Show recently searched section:
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Recent Searches")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            Button("Clear"){
                                viewModel.clearSearchHistory()
                            }
                            .font(.subheadline)
                            .foregroundStyle(.red)
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                        
                        ForEach(viewModel.searchHistory, id: \.self) { searchedArticle in
                            Button {
                                Task {
                                    await viewModel.searchNews(query: searchedArticle)
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .foregroundStyle(.gray)
                                    
                                    Text(searchedArticle.description.capitalized)
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                
                // Search Results:
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ArticleListView(articles: viewModel.articles)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Look for something")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchNews(query: searchText)
                }
            }
            
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
        .tint(.red)
        .onAppear {
            Task {
                await viewModel.fetchDefaultNews()
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(NewsViewModel())
        
}
