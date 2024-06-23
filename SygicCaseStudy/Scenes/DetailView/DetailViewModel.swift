//
//  DetailViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    private let coordinator: DashboardCoordinator
    let subscriptionItem: SubscriptionItem

    init(coordinator: DashboardCoordinator, subscriptionItem: SubscriptionItem) {
        self.coordinator = coordinator
        self.subscriptionItem = subscriptionItem
    }
    
    func convertServerToReadableTime() -> String? {
        guard let date = DateFormatter.serverDateFormatter.date(from: subscriptionItem.snippet.publishedAt) else {
            return nil
        }

        let timeStamp = DateFormatter.readableDateFormatter.string(from: date)

        return timeStamp
    }
    
}
