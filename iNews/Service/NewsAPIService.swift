//
//  NewsAPI.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import Foundation

struct NewsAPIService {
    static let shared = NewsAPIService()
    private init() {}
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    private let apiKey: String = "a2a7e8addcc3473b8c37f2efcc5c8f5c"
    
    
    public func fetchNews(from category: Category) async throws -> [Article] {
        let urlString = generateNewsURL(from: category)
        return try await fetchArticles(urlString: urlString)
    }
    
    
    public func searchNews(for query: String) async throws -> [Article] {
        let urlString = generateaSearchURL(from: query)
        return try await fetchArticles(urlString: urlString)
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
    
    private func generateNewsURL(from category: Category) -> String {
        return "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&language=en&category=\(category.rawValue)"
    }
    
    
    private func generateaSearchURL(from query: String) -> String {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        return "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&language=en&q=\(percentEncodedString)"
    }
    
}


// API url: "https://newsapi.org/v2/everything?q=tesla&from=2025-01-13&sortBy=publishedAt&apiKey=a2a7e8addcc3473b8c37f2efcc5c8f5c"
