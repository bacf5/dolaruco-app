//
//  FetchService.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 17.09.25.
//

import Foundation

struct FetchService {
    
    private enum FetchError: Error {
        case badResponse
    }
    
    // dolar fetch
    
    private var dollarApi = URL(
        string: "https://dolarapi.com/v1/dolares/oficial"
    )!
    
    func fetchDollarOficial() async throws -> Currency {
        
        // fetch
        let (data, response) = try await URLSession.shared.data(from: dollarApi)
        
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // decode data
        let dollarData = try JSONDecoder().decode(Currency.self, from: data)
        // return data
        
        return dollarData
        
    }
    
}




