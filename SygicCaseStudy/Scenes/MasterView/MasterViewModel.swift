//
//  MasterViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation
import GoogleSignIn

protocol MasterViewModelProtocol {
    func fetchSubscriptions() async
    func pageLoadSubscriptions(subscription: SubscriptionItem) async
    func push(page: DashboardCoordinator.Page)
    func reloadSubscriptions(withWipe: Bool) async
}

@MainActor
class MasterViewModel: MasterViewModelProtocol, ObservableObject {
    @Published var sortSelection: SortType = .alphabetical
    @Published var errorMessage: String = ""
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var notFetched = true

    var subscriptionItemsResponse: [SubscriptionItem] = []
    private let coordinator: DashboardCoordinator
    private let networkingService: NetworkingService
    private let user: GIDGoogleUser
    private var nextPageToken: String?

    var subscriptionItems: [SubscriptionItem] {
        guard !searchText.isEmpty else {
            return subscriptionItemsResponse
        }
        
        return subscriptionItemsResponse.filter {
            $0.snippet.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    init(coordinator: DashboardCoordinator, networkingService: NetworkingService, user: GIDGoogleUser) {
        self.coordinator = coordinator
        self.networkingService = networkingService
        self.user = user
    }
    
    nonisolated func push(page: DashboardCoordinator.Page) {
        coordinator.pushPage(to: .subscriptions, page)
    }
    
    func reloadSubscriptions(withWipe: Bool = false) async {
        if withWipe {
            nextPageToken = nil
            subscriptionItemsResponse = []
            notFetched = true
        }
    
        await fetchSubscriptions()
        notFetched = false
    }
    
    func pageLoadSubscriptions(subscription: SubscriptionItem) async {
        guard let lastSubscription = self.subscriptionItems.last else {
            return
        }

        if subscription.id == lastSubscription.id && nextPageToken != nil && isLoading == false {
            await fetchSubscriptions()
        }
    }
    
    func fetchSubscriptions() async {
        do {
            isLoading = true
            let subscriptionsResult: ResponseResult<SubscriptionsResponse, SubscriptionsResponse.Error> = try await networkingService.getData(for: .subscriptions(nextPageToken, sortSelection.rawValue.lowercased()), with: user)
            switch subscriptionsResult {
            case .data(let response):
                try await response.items.asyncForEach { item in
                    let defaultThumbnail = item.snippet.thumbnails.thumbnailsDefault
                    defaultThumbnail.imageData = try await networkingService.getImage(for: defaultThumbnail.url)
                }
                subscriptionItemsResponse.append(contentsOf: response.items)
                nextPageToken = response.nextPageToken
            case .error(let error):
                errorMessage = error.error.message
            }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
