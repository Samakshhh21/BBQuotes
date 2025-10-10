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
        
    }
}
