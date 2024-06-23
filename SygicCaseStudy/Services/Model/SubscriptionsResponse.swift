//
//  SubscriptionsResponse.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation
import UIKit

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
    
    mutating func addImageData(data: Data?) {
        snippet.thumbnails.thumbnailsDefault.imageData = data
    }

    static func generateRandomData() -> SubscriptionItem {
        return SubscriptionItem(
            kind: "youtube#subscription",
            etag: "JlsDk8nUFfbiqSoyMO29u8F39Ew",
            id: UUID().uuidString,
            snippet: Snippet(
                publishedAt: "2019-02-16T17:10:31.500199Z",
                title: Self.generateRandomTitle(),
                description: "",
                resourceID: ResourceID(
                    kind: "youtube#channel",
                    channelID: "UCKpsvL3xKoXgAaOzYNinlBQ"
                ),
                channelID: "UCJY-3RAm3bK8j33D5GU7SFg",
                thumbnails: Thumbnails(
                    thumbnailsDefault: Default(
                        url: "https://yt3.ggpht.com/cTviVjYNKLUFxWeqL58sA3lASt2Opsgq-h_yEtcI82YsvFdTn7VQqC6IrWRibhm0Qbx1LKmktg=s88-c-k-c0x00ffffff-no-rj",
                        imageData: UIImage(named: "youtubeLogo")?.pngData()
                    ),
                    medium: Default(
                        url: "https://yt3.ggpht.com/cTviVjYNKLUFxWeqL58sA3lASt2Opsgq-h_yEtcI82YsvFdTn7VQqC6IrWRibhm0Qbx1LKmktg=s88-c-k-c0x00ffffff-no-rj"
                    ),
                    high: Default(
                        url: "https://yt3.ggpht.com/cTviVjYNKLUFxWeqL58sA3lASt2Opsgq-h_yEtcI82YsvFdTn7VQqC6IrWRibhm0Qbx1LKmktg=s88-c-k-c0x00ffffff-no-rj"
                    )
                )
            )
        )
    }
    
    private static func generateRandomTitle() -> String {
        return ["Academia de Tranzacționare","Andrea Cimi","ATX Airborne","Abu Rezwan"].randomElement() ?? "Abu Rezwan"
    }
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
struct Default: Codable {
    let url: String
    var imageData: Data?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
