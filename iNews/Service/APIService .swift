//
//  APIService .swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.error("Error: Invalid URL")
        }
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.error("Error: Invalid HTTP Response code.")
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as URLError {
            print("Error: \(decodingError.localizedDescription)")
            throw APIError.error("Error: \(decodingError.localizedDescription)")
        } catch {
            print("Uknown error occurred: \(error.localizedDescription)")
            throw APIError.error("Uknown error occurred: \(error.localizedDescription)")
        }
        
        
    }
    
}
