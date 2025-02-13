//
//  ArticleModel.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

/*
 struct NewsResponse: Codable {
     let status: String
     let totalResults: Int
     let articles: [Article]
     
     struct Article: Codable, Equatable, Identifiable {
         var id: String { url }
         let source: Source
         let title: String
         let url: String
         let publishedAt: String
         let content: String?
         let author: String?
         let description: String?
         let urlToImage: String?
         
         var authorText: String {
             author ?? ""
         }
         
         var descriptionText: String {
             description ?? ""
         }
         
         var articleURL: URL {
             URL(string: url)!
         }
         
         var imageURL: URL? {
             guard let urlToImage = urlToImage else { return nil }
             return URL(string: urlToImage)
         }
         
     }

     struct Source: Codable, Equatable {
         let id: String?
         let name: String
     }
 }


 */

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article: Codable, Equatable, Identifiable {
    let id = UUID()
    
    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case source, title, url, publishedAt, author, description, urlToImage
    }
    var authorText: String {
        author ?? ""
    }
    var descriptionText: String {
        description ?? ""
    }
    var captionText: String {
        "\(source.name) . \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()) )"
    }
    var articleURL: URL {
        URL(string: url)!
    }
    var imageURL: URL? {
        guard let urlToImage = urlToImage else { return nil }
        return URL(string: urlToImage)
    }
    
    struct Source: Codable, Equatable {
        let name: String
    }
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! decoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}
