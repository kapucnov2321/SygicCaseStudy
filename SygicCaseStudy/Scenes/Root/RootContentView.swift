//
//  CoordinatorContentView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject var coordinator = RootCoordinator()

    var body: some View {
        AppBackground {
            switch coordinator.rootView {
            case .login:
                LoginView(viewModel: LoginViewModel(coordinator: coordinator))
            case .initial:
                InitialView(viewModel: InitialViewModel(coordinator: coordinator))
            case .dashboard(let user):
                DashboardContentView(rootCoordinator: coordinator, user: user)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RootContentView()
}



