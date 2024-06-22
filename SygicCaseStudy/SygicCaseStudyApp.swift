//
//  SygicCaseStudyApp.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI
import GoogleSignIn

@main
struct SygicCaseStudyApp: App {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some Scene {
        WindowGroup {
            RootContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .preferredColorScheme(.dark)
        }
    }
}
