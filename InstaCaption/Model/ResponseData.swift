//
//  UploadImageData.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 21.12.2021.
//

import Foundation

// MARK: - Welcome
struct ResponseData: Codable {
    let result: UploadResult
    let status: UploadStatus
}

// MARK: - Result
struct UploadResult: Codable {
    let uploadID: String

    enum CodingKeys: String, CodingKey {
        case uploadID = "upload_id"
    }
}

// MARK: - Status
struct UploadStatus: Codable {
    let text, type: String
}
