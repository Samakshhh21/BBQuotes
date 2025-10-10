//
//  FetchService.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 08/10/25.
//
import Foundation
struct FetchService{
    
    private enum FetchError: Error{
        case badRequest
    }

    
   private let baseURL = URL(string : "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(show : String) async throws -> Quote{
        //BUILD FETCH URL
        let quoteURL = baseURL.appendingPathComponent("quotes").appendingPathComponent("random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)] )
        
        //fetch data
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        // handle response
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
        }
        
        //decode data
        let decoder = JSONDecoder()
        let quote = try decoder.decode(Quote.self, from: data)
        
        //return quote
        return quote
        
    }
    
    func fetchCharacter(name : String) async throws -> Char{
        let charURL = baseURL.appendingPathComponent("characters")
        let fetchURL = charURL.appending(queryItems: [URLQueryItem(name: "name", value: name)] )
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Char].self, from: data)
        
        return characters[0]
        
    }
    
    func fetchDeath(character : String) async throws -> Death?{
        let fetchURL = baseURL.appendingPathComponent("deaths")
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths{
            if death.character == character{
                return death
            }
        }
        return nil
    }
}
