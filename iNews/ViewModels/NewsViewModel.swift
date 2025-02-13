//
//  NewsViewModel.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

@MainActor
final class NewsViewModel: ObservableObject {
    let article: [Article] = []
    let isLoading: Bool = false

    let apiService = NewsAPIService.shared
    
}
