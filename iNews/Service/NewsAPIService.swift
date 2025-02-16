//
//  NewsAPI.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import Foundation

struct NewsAPIService {
    static let shared = NewsAPIService()
    private let apiKey: String = "a2a7e8addcc3473b8c37f2efcc5c8f5c"
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    private init() {}
    
    // Function to fetch the default/general news:
    public func fetchGeneralNews() async throws -> [Article] {
        // Date formatted to get date in "yyyy-MM-dd" format:
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Getting today's date:
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        
        // Getting the date 7 days ago:
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let sevenDaysAgoString = dateFormatter.string(from: sevenDaysAgo)
        let urlString = "https://newsapi.org/v2/everything?q=headlines&from=\(sevenDaysAgoString)&to=\(todayString)&sortBy=popularity&apiKey=\(apiKey)"
        return try await fetchArticles(urlString: urlString)
    }
    
    // Function to fetch the searched category news (from the searchable modifier):
    public func searchNews(for query: String) async throws -> [Article] {
        let urlString = generateSearchURL(from: query)
        return try await fetchArticles(urlString: urlString)
    }
    
    
    // Function to fetch news based on categories of buttons in the HeadlinesView:
    public func fetchTopHeadlines(category: String) async throws -> [Article] {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"
        return try await fetchArticles(urlString: urlString)
    }
    
    // Function to generate the search url
    private func generateSearchURL(from query: String) -> String {
        // Date formatted to get date in "yyyy-MM-dd" format:
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Getting today's date:
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        
        // Getting the date 7 days ago:
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let sevenDaysAgoString = dateFormatter.string(from: sevenDaysAgo)
        
        let formattedQuery = query.lowercased().replacingOccurrences(of: " ", with: "-")
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? formattedQuery
        return "https://newsapi.org/v2/everything?q=\(percentEncodedString)&from=\(sevenDaysAgoString)&to=\(todayString)&sortBy=popularity&apiKey=\(apiKey)&language=en"
        
    }
    
    private func fetchArticles<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            throw APIError.error("Error: Invalid URL.")
        }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP Response Code.")
                throw APIError.error("Error: Invalid HTTP Response Code.")
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let apiResponse = try decoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles as! T
            } else {
                print(apiResponse.message ?? "An error occurred.")
                throw APIError.error(apiResponse.message ?? "An error occurred")
            }
            
        } catch let decodingError as DecodingError {
            print("Decoding Error: \(decodingError.localizedDescription)")
            throw APIError.error("Decoding Error: \(decodingError.localizedDescription)")
        } catch let urlError as URLError {
            print("URL Error: \(urlError.localizedDescription)")
            throw APIError.error("URL Error: \(urlError.localizedDescription)")
        } catch {
            print("An unknown error occurred: \(error.localizedDescription)")
            throw APIError.error("An unknown error occurred: \(error.localizedDescription)")
        }
        
    }
}


// API url: "https://newsapi.org/v2/everything?q=tesla&from=2025-01-13&sortBy=publishedAt&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"

// Different APIs for different responses:
/*
 ** API that serches for anything and everything:
 "https://newsapi.org/v2/everything?q=\(searchQuery)&sortBy=popularity&apiKey=\(apiKey)"
 The search query works for any given area, eg: apple, tesla, samsung, headlines, general...... anything
 
 ex:
 "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c&language=en"
 
 
 1. Top Headlines in the US:
 "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
 
 2. Top Headlines from TechCrunch right now
 "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
 
 3. All Apple mentioning articles:
 with sorted dates:
 "https://newsapi.org/v2/everything?q=apple&from=2025-02-12&to=2025-02-12&sortBy=popularity&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
 without sorted dates:
 "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"

 4. All Tesla mentioning articles:
 with dates:
 "https://newsapi.org/v2/everything?q=tesla&from=2025-01-13&sortBy=publishedAt&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
 without dates:
 "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
 
 
 
 */
