//
//  RootViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import Foundation
import GoogleSignIn

class InitialViewModel: ObservableObject {
    private var coordinator: RootCoordinator
    
    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    func changeRootView(to rootView: RootCoordinator.View) {
        coordinator.changeRootView(to: rootView)
    }
    
    func checkIfSignedIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let user = user else {
                self?.changeRootView(to: .login)
                return
            }
            
            self?.changeRootView(to: .dashboard(user))
        }
    }
}
