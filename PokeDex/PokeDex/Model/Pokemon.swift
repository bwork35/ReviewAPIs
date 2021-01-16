//
//  Pokemon.swift
//  PokeDex
//
//  Created by Bryan Workman on 1/15/21.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let classicSpriteURL: URL
        
        enum CodingKeys: String, CodingKey {
            case classicSpriteURL = "front_default"
        }
    }
} //End of struct
