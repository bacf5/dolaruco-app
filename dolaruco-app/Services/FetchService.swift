//
//  FetchService.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 17.09.25.
//

import Foundation

enum NetworkError: Error {
    case InvalidResponse
}

struct FetchService {
    
    func getCurrency(url: URL) async throws -> [Currency] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.InvalidResponse
        }
        
        return try JSONDecoder().decode([Currency].self, from: data)
    }
}





