//
//  FilterTypes.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

enum SortType: String, CaseIterable, Identifiable {
    case alphabetical = "Alphabetical"
    case relevance = "Relevance"
    
    var id: SortType {
        return self
    }
    
    var icon: String {
        switch self {
        case .alphabetical:
            return "textformat"
        case .relevance:
            return "star"
        }
    }
}
