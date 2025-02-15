//
//  ContentView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var isLoading: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                ArticleListView(articles: viewModel.articles)
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchQuery, prompt: "Look for something")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchNews()
                }
            }
            .tint(.red)
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
            
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(NewsViewModel())
        
}
