//
//  ImageData.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 21.12.2021.
//

import Foundation

// MARK: - Welcome
struct ImageData: Codable {
    let result: Result
    let status: Status
}

// MARK: - Result
struct Result: Codable {
    let tags: [Element]
}

// MARK: - TagElement
struct Element: Codable {
    let confidence: Double
    let tag: Tag
}

// MARK: - TagTag
struct Tag: Codable {
    let en: String
}

// MARK: - Status
struct Status: Codable {
    let text, type: String
}
