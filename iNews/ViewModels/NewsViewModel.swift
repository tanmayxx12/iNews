//
//  NewsViewModel.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var news: NewsResponse?
    
    
    init(isPreview: Bool = false) {
        if isPreview {
            self.news = DeveloperPreview.instance.previewData
        }
    }
    
}
