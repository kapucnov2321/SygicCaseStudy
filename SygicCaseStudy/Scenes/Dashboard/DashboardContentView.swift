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
                AppBackground {
                    MasterView(
                        viewModel: MasterViewModel(
                            coordinator: dashboardCoordinator,
                            networkingService: NetworkingService(),
                            user: user
                        )
                    )
                }
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
            AppBackground {
                AccountView(viewModel: AccountViewModel(coordinator: rootCoordinator, user: user))
            }
            .tabItem {
                Label("Account", systemImage: "person")
            }
        }
        
    }
}


#Preview {
    DashboardContentView(dashboardCoordinator: DashboardCoordinator(), rootCoordinator: RootCoordinator(), user: GIDGoogleUser())
}
