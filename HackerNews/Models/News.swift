//
//  News.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 04/04/24.
//

import Foundation
// MODELOS DE DATOS se convierte el json en codigo legible en swift para traer los datos de la URL

// MARK: - Welcome
struct News: Codable, Hashable {
    let exhaustive: Exhaustive
    let exhaustiveNbHits, exhaustiveTypo: Bool
    var hits: [Hit]
    let hitsPerPage, nbHits, nbPages, page: Int
    let params: String
    let processingTimeMS: Int
    let processingTimingsMS: ProcessingTimingsMS
    let query: String
    let serverTimeMS: Int
}

// MARK: - Exhaustive
struct Exhaustive: Codable, Hashable {
    let nbHits, typo: Bool
}

// MARK: - Hit
struct Hit: Codable, Hashable {
    let highlightResult: HighlightResult
    let tags: [String]
    let author: String
    let commentText: String?
    let createdAt: String
    let createdAtI: Int
    let objectID: String
    let parentID: Int?
    let storyID: Int
    let storyTitle: String?
    let storyURL: String?
    let updatedAt: String?
    let children: [Int]?
    let numComments, points: Int?
    let title: String?
    let url: String?
    let storyText: String?
    
    

    enum CodingKeys: String, CodingKey {
        case highlightResult = "_highlightResult"
        case tags = "_tags"
        case author
        case commentText = "comment_text"
        case createdAt = "created_at"
        case createdAtI = "created_at_i"
        case objectID
        case parentID = "parent_id"
        case storyID = "story_id"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case updatedAt = "updated_at"
        case children
        case numComments = "num_comments"
        case points, title, url
        case storyText = "story_text"
    }
}

// MARK: - HighlightResult
struct HighlightResult: Codable, Hashable {
    let author: Author
    let commentText, storyTitle, storyURL, title: Author?
    let url, storyText: Author?

    enum CodingKeys: String, CodingKey {
        case author
        case commentText = "comment_text"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case title, url
        case storyText = "story_text"
    }
}

// MARK: - Author
struct Author: Codable, Hashable {
    let matchLevel: String
    let matchedWords: [String]
    let value: String
    let fullyHighlighted: Bool?
}

enum MatchLevel: String, Codable {
    case full = "full"
    case none = "none"
    case partial = "partial"
}

enum MatchedWord: String, Codable {
    case androi = "androi"
    case d = "d"
}

// MARK: - ProcessingTimingsMS
struct ProcessingTimingsMS: Codable, Hashable {
    let request: Request
    let afterFetch: AfterFetch
    let fetch: Fetch
    let total: Int

    enum CodingKeys: String, CodingKey {
        case request = "_request"
        case afterFetch, fetch, total
    }
}

// MARK: - AfterFetch
struct AfterFetch: Codable, Hashable {
    let format: Format
  
}

// MARK: - Format
struct Format: Codable, Hashable {
    let highlighting, total: Int?
}

// MARK: - Merge
struct Merge: Codable, Hashable {
    let total: Int
}

// MARK: - Fetch
struct Fetch: Codable, Hashable {
    let query, scanning, total: Int
}

// MARK: - Request
struct Request: Codable, Hashable {
    let roundTrip: Int
}

