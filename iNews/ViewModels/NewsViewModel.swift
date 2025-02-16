//
//  NewsViewModel.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var selectedCategory: String = "general"
    @Published var searchHistory: [String] = []
    
    private let userDefaults = UserDefaults.standard
    private let searchHistoryKey: String = "searchHistory" // Used for UserDefaults
    let newsService = NewsAPIService.shared
     
    // Initializer comes here if any:
    
   
    func fetchDefaultNews() async {
        do {
            let fetchedArticles = try await newsService.fetchGeneralNews()
            self.articles = fetchedArticles
        } catch {
            print("Error fetching default news")
        }
    }
    
    // Function to fetch top headlines for various categories:
    func fetchArticles(for category: String) {
        isLoading = true
        selectedCategory = category
        Task {
            do {
                let fetchedArticles = try await newsService.fetchTopHeadlines(category: category)
                self.articles = fetchedArticles
                self.isLoading = false
            } catch {
                print("Error fetching articles: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
        
    }
    
    // Fetches news based on search query:
    func searchNews(query: String) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            await fetchDefaultNews()
            return
        }
        
        addToSearchHistory(query)
        
        isLoading = true
        do {
            let fetchedArticles = try await newsService.searchNews(for: query)
            self.articles = fetchedArticles
            self.isLoading = false
        } catch {
            print("Error serching news: \(error.localizedDescription)")
        }
    }
    
    
    private func addToSearchHistory(_ query: String) {
        // Remove if already exists to avoid duplicates:
        searchHistory.removeAll{ $0.lowercased() == query.lowercased() }
        
        // Add to beginning of the array:
        searchHistory.insert(query, at: 0)
        
        // Keep only last 5 searches:
        if searchHistory.count > 5 {
            searchHistory.remove(at: 5)
        }
        
        // Save to user defaults:
        userDefaults.set(searchHistory, forKey: searchHistoryKey)
    }
    
    func clearSearchHistory() {
        searchHistory.removeAll()
        userDefaults.removeObject(forKey: searchHistoryKey)
    }
}



