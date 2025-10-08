//
//  Char.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 08/10/25.
//

import Foundation
struct Char : Decodable{
    let name : String
    let birthday : String
    let occupation : [String]
    let images : [URL]
    let aliases : [String]
    let portrayedBy : String
    let status : String
}
