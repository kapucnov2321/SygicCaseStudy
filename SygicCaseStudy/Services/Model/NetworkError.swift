//
//  NetworkError.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case urlConstructionError
    case badResponse
    case unexpectedError

    var errorDescription: String? {
        switch self {
        case .urlConstructionError:
            return "Cannot construct URL"
        case .badResponse:
            return "Response not valid"
        case .unexpectedError:
            return "Unexpected server error"
        }
    }
}
