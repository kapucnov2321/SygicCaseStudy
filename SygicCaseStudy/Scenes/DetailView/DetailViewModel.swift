//
//  DetailViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

protocol DetailViewModelProtocol {
}

class DetailViewModel: DetailViewModelProtocol, ObservableObject {
    private let coordinator: DashboardCoordinator
    let subscriptionItem: SubscriptionItem

    init(coordinator: DashboardCoordinator, subscriptionItem: SubscriptionItem) {
        self.coordinator = coordinator
        self.subscriptionItem = subscriptionItem
    }
    
}
