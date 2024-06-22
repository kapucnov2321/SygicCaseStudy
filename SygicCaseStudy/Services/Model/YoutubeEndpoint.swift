//
//  YoutubeEndpoint.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation
import GoogleSignIn

enum YoutubeEndpoint {
    static let baseURL = "https://youtube.googleapis.com/youtube"

    case subscriptions(String?, String)

    var path: String {
        switch self {
        case .subscriptions:
            return "/v3/subscriptions"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .subscriptions(let nextPageToken, let order):
            return [
                URLQueryItem(name: "part", value: "snippet"),
                URLQueryItem(name: "mine", value: "true"),
                URLQueryItem(name: "pageToken", value: nextPageToken),
                URLQueryItem(name: "order", value: order)
            ]
        }
    }

    var method: String {
        switch self {
        case .subscriptions:
            return "GET"
        }
    }
    
    func generateRequest(user: GIDGoogleUser) throws -> URLRequest {
        var urlComponents = URLComponents(string: Self.baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw NetworkError.urlConstructionError
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("Bearer \(user.accessToken.tokenString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return  request
    }
}
