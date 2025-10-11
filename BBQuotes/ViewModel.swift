//
//  ViewModel.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 10/10/25.
//


import Foundation

@Observable
@MainActor
class ViewModel {
    enum fetchStatus {
        case notStarted
        case fetching
        case success
        case failure(error : Error)
    }
    private(set) var status = fetchStatus.notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character : Char
    
    init(){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let charData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Char.self, from: charData)
        
    }
    
    func getData(show : String) async {
        status = .fetching
        do {
             quote = try await fetcher.fetchQuote(show: show)
            character = try await fetcher.fetchCharacter(name: quote.character)
            character.death = try await fetcher.fetchDeath(character: character.name)
            status = .success
            
        }catch {
            status = .failure(error: error)
        }
    }
}
