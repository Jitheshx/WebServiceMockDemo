//
//  Track.swift
//  WebServiceMockDemo
//
//  Created by Jithesh Xavier on 09/06/23.
//

import Foundation

struct TrackStore: Codable {
    let resultCount: Int?
    let results: [Track]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resultCount = try container.decodeIfPresent(Int.self, forKey: .resultCount)
        self.results = try container.decodeIfPresent([Track].self, forKey: .results)
    }
}

// MARK: - Result
struct Track: Codable {
    let wrapperType: String?
    let artistID, collectionID: Int?
    let artistName, collectionName, collectionCensoredName: String?
    let artistViewURL, collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let country, currency: String?
    let primaryGenreName: String?
    let previewURL: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, country, currency, primaryGenreName
        case previewURL = "previewUrl"
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wrapperType = try container.decodeIfPresent(String.self, forKey: .wrapperType)
        self.artistID = try container.decodeIfPresent(Int.self, forKey: .artistID)
        self.collectionID = try container.decodeIfPresent(Int.self, forKey: .collectionID)
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        self.collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
        self.collectionCensoredName = try container.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        self.artistViewURL = try container.decodeIfPresent(String.self, forKey: .artistViewURL)
        self.collectionViewURL = try container.decodeIfPresent(String.self, forKey: .collectionViewURL)
        self.artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        self.collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice)
        self.collectionExplicitness = try container.decodeIfPresent(String.self, forKey: .collectionExplicitness)
        self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)
        self.previewURL = try container.decodeIfPresent(String.self, forKey: .previewURL)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
