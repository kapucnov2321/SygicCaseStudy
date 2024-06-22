//
//  Coordinator.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI
import GoogleSignIn

class RootCoordinator: ObservableObject {
    @Published var rootView: View = .initial
    
    func changeRootView(to rootView: View) {
        withAnimation {
            self.rootView = rootView
        }
    }
    
    enum View: Hashable {
        case login
        case dashboard(GIDGoogleUser)
        case initial
    }
    
    enum NavigationPage: Hashable {
        case detail
    }
}
