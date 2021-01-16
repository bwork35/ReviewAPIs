//
//  Post.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let data: Post
}

struct Post: Decodable {
    let title: String
    let thumbnail: URL?
    let ups: Int
}
