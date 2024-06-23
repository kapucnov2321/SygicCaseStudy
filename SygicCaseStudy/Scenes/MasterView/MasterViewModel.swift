//
//  MasterViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import Foundation
import GoogleSignIn

@MainActor
class MasterViewModel: ObservableObject {
    @Published var sortSelection: SortType = .alphabetical
    @Published var errorMessage: String = ""
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var didFetchDataFirstTime = false

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
            didFetchDataFirstTime = false
        }
    
        await fetchSubscriptions()
        didFetchDataFirstTime = true
    }
    
    func pageLoadSubscriptions(subscription: SubscriptionItem) async {
        guard let lastSubscription = self.subscriptionItems.last else {
            return
        }

        if subscription.id == lastSubscription.id && nextPageToken != nil && isLoading == false {
            await fetchSubscriptions()
        }
    }
    
    private func fetchSubscriptions() async {
        do {
            isLoading = true
            let subscriptionsResult: ResponseResult<SubscriptionsResponse, SubscriptionsResponse.Error> = try await networkingService.getData(for: .subscriptions(nextPageToken, sortSelection.rawValue.lowercased()), with: user)
            switch subscriptionsResult {
            case .data(let response):
                let imagedItems = try await fetchSubscriptionImages(response: response)
                subscriptionItemsResponse.append(contentsOf: imagedItems)
                nextPageToken = response.nextPageToken
            case .error(let error):
                errorMessage = error.error.message
            }
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func fetchSubscriptionImages(response: SubscriptionsResponse) async throws -> [SubscriptionItem] {
        let responseItems = try await response.items.asyncMap { item in
            var newItem = item
            let defaultThumbnail = item.snippet.thumbnails.thumbnailsDefault
            let imageData = try await networkingService.getImage(for: defaultThumbnail.url)
            newItem.addImageData(data: imageData)
            return newItem
        }
        return responseItems
    }
}
