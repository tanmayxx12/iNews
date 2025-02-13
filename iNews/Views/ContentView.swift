//
//  ContentView.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @State var searchedText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
            }
            .searchable(text: $searchedText, prompt: "Enter any field...")
            .onSubmit(of: .search) {
                Task {
                    // await the function that fetches the response from the server in the NewsViewModel
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NewsViewModel(isPreview: true))
}
