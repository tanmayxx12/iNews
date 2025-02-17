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
    // Variable to show bookmarked articles:
    @Published var bookmarkedArticles: [Article] = []
    @Published var isSortedByNewest: Bool = true
    
    private let userDefaults = UserDefaults.standard
    private let searchHistoryKey: String = "searchHistory" // Used for UserDefaults
    private let bookmarksKey: String = "bookmarkedArticles"
    let newsService = NewsAPIService.shared
     
    // Initializer comes here if any:
    
   
    // MARK: - Function to fetch default news:
    func fetchDefaultNews() async {
        do {
            let fetchedArticles = try await newsService.fetchGeneralNews()
            self.articles = fetchedArticles
        } catch {
            print("Error fetching default news")
        }
    }
    
    // MARK: - Function to fetch top headlines for various categories:
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
    
    // MARK: - Fetches news based on search query:
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
    
    
    // MARK: - Function to add search query to the search history
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
    
    // MARK: - Function to clear the search history
    func clearSearchHistory() {
        searchHistory.removeAll()
        userDefaults.removeObject(forKey: searchHistoryKey)
    }
    
    // MARK: - Adding functionality to bookmark an article:
    func toggleBookmark(for article: Article) {
        if isBookmarked(article) {
            bookmarkedArticles.removeAll{ $0.url == article.url}
            print("Article Removed.")
        } else {
            bookmarkedArticles.append(article)
            print("Article Bookmarked")
        }
        saveBookmarkedArticles()
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        return bookmarkedArticles.contains { $0.url == article.url }
    }
    
    private func saveBookmarkedArticles() {
        if let encoded = try? JSONEncoder().encode(bookmarkedArticles) {
            userDefaults.set(encoded, forKey: bookmarksKey)
        }
    }
    
    private func loadBookmarkedArticles() {
        if let data = userDefaults.data(forKey: bookmarksKey),
           let decoded = try? JSONDecoder().decode([Article].self, from: data) {
            self.bookmarkedArticles = decoded
        }
    }
    
    
    // MARK: - Function to sort artilces based on their published dates:
    // For general articles from the web:
    private func sortArticles() {
        articles.sort { article1, article2 in
            let date1 = article1.publishedAt
            let date2 = article2.publishedAt
            return isSortedByNewest ? date1 > date2 : date1 < date2
        }
    }
    
    // For Bookmarked Articles:
    private func sortBookmarkedArticles() {
        bookmarkedArticles.sort { article1, article2 in
            let date1 = article1.publishedAt
            let date2 = article2.publishedAt
            return isSortedByNewest ? date1 > date2 : date1 < date2
        }
    }
    
    // Function to toggle the sort order for both the general articles and the bookmarked articles:
    func toggleSortOrder() {
        isSortedByNewest.toggle()
        sortArticles()
        sortBookmarkedArticles()
    }
    
}



