//
//  Photo.swift
//  PhotoShare
//
//  Created by AlphaDVLPR on 8/15/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import Foundation

struct TopLevelDictionary : Codable {
    
    let totalHits: Int
    let hits: [PhotoObjects]
    let total: Int
}

struct PhotoObjects :Codable {
    
    let likes : Int
    let tags : String
    let image : String
    
    private enum CodingKeys : String, CodingKey {
        case likes
        case tags
        case image = "largeImageURL"
    }
}
