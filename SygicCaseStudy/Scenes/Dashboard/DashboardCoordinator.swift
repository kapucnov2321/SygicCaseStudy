//
//  DashboardCoordinator.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import SwiftUI

class DashboardCoordinator: ObservableObject {
    @Published var subscriptionsNavigationPath = NavigationPath()

    func pushPage(to destination: Destination, _ screen: Page) {
        switch destination {
        case .subscriptions:
            subscriptionsNavigationPath.append(screen)
        }
    }
    
    enum Page: Hashable {
        case detail(SubscriptionItem)
        
        var id: String {
            switch self {
            case .detail(let subscriptionItem):
                return subscriptionItem.id
            }
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
        }
        
        static func == (lhs: DashboardCoordinator.Page, rhs: DashboardCoordinator.Page) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    enum Destination {
        case subscriptions
    }
}
