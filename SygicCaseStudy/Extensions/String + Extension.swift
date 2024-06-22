//
//  String + Extension.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

extension String {
    func convertDateFormater() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
}
