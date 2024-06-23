//
//  LoginViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift

class LoginViewModel: ObservableObject {
    private var coordinator: RootCoordinator
    
    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    func changeRootView(to rootView: RootCoordinator.View) {
        coordinator.changeRootView(to: rootView)
    }

    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
            
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController,
            hint: nil,
            additionalScopes: ["https://www.googleapis.com/auth/youtube.readonly"]
        ) { [weak self] signInResult, error in
            guard let result = signInResult else {
              // Inspect error
              return
            }
           
            self?.changeRootView(to: .dashboard(result.user))
          }
    }
}
