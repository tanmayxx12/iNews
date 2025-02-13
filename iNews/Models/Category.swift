//
//  Category.swift
//  iNews
//
//  Created by Tanmay . on 14/02/25.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: Self { self }
    case general
    case business
    case technology
    case science
    case entertainment
    case sports
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
    
    
}
