//
//  DetailView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import SwiftUI

import SwiftUI
import GoogleSignIn

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    Image(data: viewModel.subscriptionItem.snippet.thumbnails.thumbnailsDefault.imageData)
                    Text(viewModel.subscriptionItem.snippet.title)
                        .font(.title)
                    if viewModel.subscriptionItem.snippet.description != "" {
                        Text(viewModel.subscriptionItem.snippet.description)
                            .font(.subheadline)
                    }
                    if let subAt = viewModel.convertServerToReadableTime() {
                        Text("Subscribed at: \(subAt)")
                    }
                    if let url = URL(string: "https://www.youtube.com/channel/\(viewModel.subscriptionItem.snippet.resourceID.channelID)") {
                        Link("Open in Safari", destination: url)
                            .font(.headline)
                            .foregroundStyle(.accentRed)
                    }
                }
                .padding()
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
        }
        .modifier(AppBackground())
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(coordinator: DashboardCoordinator(), subscriptionItem: SubscriptionItem.generateRandomData()))
}
