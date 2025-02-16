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
                if searchText.isEmpty {
                    
                }
                
                
                
                ArticleListView(articles: viewModel.articles)
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Look for something")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchNews(query: searchText)
                }
            }
            .tint(.red)
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
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
