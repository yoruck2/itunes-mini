//
//  Search.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation

struct Search: Decodable {
    let resultCount: Int
    let results: [Application]
}

struct Application: Decodable {
    let artworkUrl60: String
    let artworkUrl100: String
    let artworkUrl512: String
    let screenshotUrls: [String]
    let kind: String
    let trackName: String
    let artistId: Int
    let artistName: String
    let genres: [String]
    let averageUserRating: Double
    let description: String
    let releaseNotes: String
    let version: String
}
