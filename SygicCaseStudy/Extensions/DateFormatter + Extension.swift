//
//  String + Extension.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

extension DateFormatter {
    
    static let serverDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            return dateFormatter
        }()
    
    static let readableDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter
    }()
}
