//
//  Artist.swift
//  ArtistSearch00
//
//  Created by Bryan Workman on 1/27/21.
//

import Foundation

struct TopLevelObject: Decodable {
    let message: SecondLevelObject
}

struct SecondLevelObject: Decodable {
    let body: ThirdLevelObject
}

struct ThirdLevelObject: Decodable {
    let artistList: [ArtistObject]
    
    private enum CodingKeys: String, CodingKey {
        case artistList = "artist_list"
    }
}

struct ArtistObject: Decodable {
    let artist: Artist
}

struct Artist: Decodable {
    let artistName: String
    let artistTwitterURL: String
    
    private enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case artistTwitterURL = "artist_twitter_url"
    }
}
