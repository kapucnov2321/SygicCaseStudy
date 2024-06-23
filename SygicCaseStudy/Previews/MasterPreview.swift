//
//  MasterPreviewViewModel.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 23/06/2024.
//

import SwiftUI
import GoogleSignIn

struct MasterPreview: View {
    var body: some View {
        NavigationStack {
            MasterView(viewModel: MasterPreviewModel())
        }
    }
}

class MasterPreviewModel: MasterViewModel {
    let sampleData: [SubscriptionItem] = [.generateRandomData(), .generateRandomData()]

    override var subscriptionItemsResponse: [SubscriptionItem] {
        get {
            return sampleData
        }
        set {
            
        }
    }
    init() {
        super.init(coordinator: DashboardCoordinator(), networkingService: NetworkingService.shared, user: GIDGoogleUser())
    }
    
    override func reloadSubscriptions(withWipe: Bool = false) async {
        didFetchDataFirstTime = true
    }
}
