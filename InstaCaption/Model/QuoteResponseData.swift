//
//  QuoteResponseData.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 23.12.2021.
//

import Foundation

// MARK: - Welcome
import Foundation

// MARK: - Welcome
struct QuoteResponseData: Codable {
    let count, totalCount, page, totalPages: Int
    let results: [QuoteResult]
}

// MARK: - Result
struct QuoteResult: Codable {
    let id: String
    let tags: [String]
    let content, author, authorID, authorSlug: String
    let length: Int
    let dateAdded, dateModified: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags, content, author
        case authorID = "authorId"
        case authorSlug, length, dateAdded, dateModified
        case v = "__v"
    }
}
