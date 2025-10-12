//
//  ContentView.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 05/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab("Breaking Bad" , systemImage: "tortoise"){
                QuoteView(show: "Breaking Bad")
            }
            Tab("Better Call Saul", systemImage: "briefcase"){
                QuoteView(show: "Better Call Saul")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
