//
//  iNewsApp.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import SwiftUI

@main
struct iNewsApp: App {
    @StateObject var viewModel = NewsViewModel()
    var body: some Scene {
        
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
