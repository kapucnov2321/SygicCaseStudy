//
//  SubscriptionsResponse.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

// MARK: - SubscriptionsResponse
struct SubscriptionsResponse : Codable {
    let nextPageToken: String?
    let items: [SubscriptionItem]

    // MARK: - SubscriptionsError
    struct Error: Codable {
        let error: ErrorMessage
    }

    // MARK: - SubscriptionsErrorMessage
    struct ErrorMessage: Codable {
        let code: Int
        let message: String
        let errors: [ErrorElement]
        let status: String
    }

    // MARK: - ErrorElement
    struct ErrorElement: Codable {
        let message, domain, reason: String
    }

}

// MARK: - Item
struct SubscriptionItem: Codable, Identifiable {
    let kind, etag, id: String
    var snippet: Snippet
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt, title, description: String
    let resourceID: ResourceID
    let channelID: String
    var thumbnails: Thumbnails

    enum CodingKeys: String, CodingKey {
        case publishedAt, title, description
        case resourceID = "resourceId"
        case channelID = "channelId"
        case thumbnails
    }
}

// MARK: - ResourceID
struct ResourceID: Codable {
    let kind, channelID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case channelID = "channelId"
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    var thumbnailsDefault, medium, high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
class Default: Codable {
    let url: String
    var imageData: Data?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
