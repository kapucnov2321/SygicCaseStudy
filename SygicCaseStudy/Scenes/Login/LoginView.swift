//
//  ContentView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Text("Login with Google")
                .font(.title2)
                .foregroundStyle(.white)
            GoogleSignInButton {
                viewModel.signIn()
            }
            .padding()
        }
        .padding()
    }
    
}

#Preview {
    LoginView(viewModel: LoginViewModel(coordinator: RootCoordinator()))
}
