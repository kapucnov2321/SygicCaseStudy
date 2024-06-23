//
//  Image + Extensions.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 23/06/2024.
//

import SwiftUI

extension Image {
    
    init?(data: Data?) {
        if let imageData = data, let uiImage = UIImage(data: imageData) {
            self = Image(uiImage: uiImage)
            return
        }
        
        return nil
    }
}
