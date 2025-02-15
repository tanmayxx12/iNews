//
//  HomeView.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    
    
    var body: some View {
        TabView {
            
            Tab("News", systemImage: "newspaper") {
                HeadlinesView(viewModel: _viewModel)
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView(viewModel: _viewModel)
            }
            
            Tab("Bookmarks", systemImage: "bookmark.fill") {
                Text("Bookmark View.")
            }
            
        }
        .tint(.red)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    HomeView()
        .environmentObject(NewsViewModel())
}
