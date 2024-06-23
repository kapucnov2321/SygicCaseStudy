//
//  AccountViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

class AccountViewModel: ObservableObject {
    private let coordinator: RootCoordinator
    let user: GIDGoogleUser

    init(coordinator: RootCoordinator, user: GIDGoogleUser) {
        self.coordinator = coordinator
        self.user = user
    }

    func logout() {
        GIDSignIn.sharedInstance.signOut()
        coordinator.changeRootView(to: .login)
    }
    
}
