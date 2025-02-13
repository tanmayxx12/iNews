//
//  iNewsApp.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

@main
struct iNewsApp: App {
    var body: some Scene {
        @StateObject var viewModel = NewsViewModel(isPreview: true)
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
