//
//  NetworkingService.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation
import GoogleSignIn

enum ResponseResult<T, E> {
    case data(T)
    case error(E)
}

struct NetworkingService {
    
    func getData<T: Codable, E: Codable>(for endpoint: YoutubeEndpoint, with user: GIDGoogleUser) async throws -> ResponseResult<T, E> {
        let user = try await user.refreshTokensIfNeeded()
        let request = try endpoint.generateRequest(user: user)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        print("---HTTP RESPONSE START---")
        print(String(data: data, encoding: String.Encoding.utf8) ?? "Cannot convert response")
        print("---HTTP RESPONSE END---")

        switch response.statusCode {
        case 200:
            return .data(try JSONDecoder().decode(T.self, from: data))
        case 403:
            return .error(try JSONDecoder().decode(E.self, from: data))
        default:
            throw NetworkError.unexpectedError
        }
    }
    
    func getImage(for urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
    
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
