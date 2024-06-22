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
        AppBackground {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        if let imageData = viewModel.subscriptionItem.snippet.thumbnails.thumbnailsDefault.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                        }
                        Text(viewModel.subscriptionItem.snippet.title)
                            .foregroundStyle(.white)
                            .font(.title)
                        Text(viewModel.subscriptionItem.snippet.description)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                        Text("Subscribed at: \(viewModel.subscriptionItem.snippet.publishedAt.convertDateFormater())")
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

        }
    }
}
