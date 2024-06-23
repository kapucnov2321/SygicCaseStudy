//
//  LogoutView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI
import GoogleSignIn

struct DashboardContentView: View {
    @StateObject var dashboardCoordinator: DashboardCoordinator = DashboardCoordinator()
    @ObservedObject var rootCoordinator: RootCoordinator
    let user: GIDGoogleUser
    
    var body: some View {
        TabView{
            NavigationStack(path: $dashboardCoordinator.subscriptionsNavigationPath) {
                MasterView(
                    viewModel: MasterViewModel(
                        coordinator: dashboardCoordinator,
                        networkingService: NetworkingService.shared,
                        user: user
                    )
                )
                .modifier(AppBackground())
                .navigationDestination(for: DashboardCoordinator.Page.self) { page in
                    switch page {
                    case .detail(let item):
                        DetailView(viewModel: DetailViewModel(coordinator: dashboardCoordinator, subscriptionItem: item))
                    }
                }
            }
            .tabItem {
                Label("Subscriptions", systemImage: "bell")
            }
            AccountView(viewModel: AccountViewModel(coordinator: rootCoordinator, user: user))
                .modifier(AppBackground())
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}


#Preview {
    DashboardContentView(dashboardCoordinator: DashboardCoordinator(), rootCoordinator: RootCoordinator(), user: GIDGoogleUser())
}
