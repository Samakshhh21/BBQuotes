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
}
