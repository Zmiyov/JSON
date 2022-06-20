//
//  SearchREsponse.swift
//  JSON
//
//  Created by Vladimir Pisarenko on 20.06.2022.
//

import Foundation


struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl60: String?
}
