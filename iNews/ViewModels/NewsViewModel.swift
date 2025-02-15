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
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var selectedCategory: String = "general"
    

     let apiService = NewsAPIService.shared
    
    // init based on search query:
    /*
     
     */
    init() {
        if searchQuery.isEmpty {
            Task {
                await fetchDefaultNews()
            }
        } else {
            Task {
                await searchNews()
            }
        }
    }

    // Init based on NewsAPIService:
    /*
     init() {
         if
     }
     */
   
    
    
    func fetchDefaultNews() async {
        do {
            let fetchedArticles = try await apiService.fetchGeneralNews()
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
                let fetchedArticles = try await apiService.fetchTopHeadlines(category: category)
                self.articles = fetchedArticles
                self.isLoading = false
            } catch {
                print("Error fetching articles: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
        
    }
    
   
    // Fetches news based on search query:
    func searchNews() async {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            await fetchDefaultNews()
            return
        }
        do {
            let fetchedArticles = try await apiService.searchNews(for: searchQuery)
            self.articles = fetchedArticles
        } catch {
            print("Error serching news: \(error.localizedDescription)")
        }
    }
    
}



