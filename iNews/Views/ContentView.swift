//
//  ContentView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ContentView: View {
    // @StateObject private var viewModel: NewsViewModel
    @State var searchedQuery: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ArticleListView(articles: Article.previewData)
            }
            .searchable(text: $searchedQuery)
            .onSubmit(of: .search) {
                Task {
                    // How do i link the NewsViewModel to the Content view's searchable modifier?
                }
            }
        }
    }
}

#Preview {
    ContentView()
        
}
