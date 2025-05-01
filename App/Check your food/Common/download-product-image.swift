//
//  download-product-image.swift
//  Check your food
//
//  Created by Pascal Sauer on 01.05.25.
//

import SwiftUI

func downloadProductImageBy(url: URL) async -> (Data?, Error?) {
    guard let url = URL(string: url.formatted()) else { return (nil, URLError(.badURL)) }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // TODO: Handle HTTP Errors
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [
                NSLocalizedDescriptionKey: "Serverfehler: HTTP \(httpResponse.statusCode)"
            ])
        }
        
        return (data, nil)
    } catch {
        print("Error: \(error.localizedDescription)")
        return (nil, error)
    }
}
