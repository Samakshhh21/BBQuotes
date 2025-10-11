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
    var death : Death?
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupation
        case images
        case aliases
        case portrayedBy
        case status
        case death
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupation = try container.decode([String].self, forKey: .occupation)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        self.status = try container.decode(String.self, forKey: .status)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deathData = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)        
        death = try container.decodeIfPresent(Death.self, forKey: .death)
    }
}
