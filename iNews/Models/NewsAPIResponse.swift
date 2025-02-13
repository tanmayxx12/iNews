//
//  NewsAPIResponse.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String? 
}
