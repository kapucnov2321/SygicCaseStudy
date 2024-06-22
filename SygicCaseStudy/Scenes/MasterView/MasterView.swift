//
//  MasterView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import SwiftUI
import GoogleSignIn

struct MasterView: View {
    @StateObject var viewModel: MasterViewModel

    var body: some View {
        LoadingView(content: {
            ScrollView {
                Text("Your subscriptions")
                    .font(.title)
                LazyVStack {
                    ForEach(viewModel.subscriptionItems) { subscription in
                        HStack {
                            if let imageData = subscription.snippet.thumbnails.thumbnailsDefault.imageData, let uiImage = UIImage(data: imageData)  {
                                Image(uiImage: uiImage)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .shadow(color: .white, radius: 5)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                            }
                            Text(subscription.snippet.title)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .onAppear {
                                    Task {
                                        await viewModel.pageLoadSubscriptions(subscription: subscription)
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.accentRed)
                        .clipShape(.rect(cornerRadius: 10))
                        .onTapGesture {
                            viewModel.push(page: .detail(subscription))
                        }
                    }
                }
                .padding()
            }
        }, isShown: $viewModel.notFetched)
        .searchable(text: $viewModel.searchText)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("Sort", selection: $viewModel.sortSelection.animation()) {
                        ForEach(SortType.allCases) { type in
                            Label(type.rawValue.capitalized, systemImage: type.icon)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
        }
        .onChange(of: viewModel.sortSelection) { _ in
            Task {
                await viewModel.reloadSubscriptions(withWipe: true)
            }
        }
        .task {
            if viewModel.notFetched {
                await viewModel.reloadSubscriptions()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MasterView(viewModel: MasterViewModel(coordinator: DashboardCoordinator(), networkingService: NetworkingService(), user: GIDGoogleUser()))
    }
}
