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
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.subscriptionItems) { subscription in
                        HStack {
                            Image(data: subscription.snippet.thumbnails.thumbnailsDefault.imageData)?
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(color: .white, radius: 5)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)

                            Text(subscription.snippet.title)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .task {
                                    await viewModel.pageLoadSubscriptions(subscription: subscription)
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
            if !viewModel.didFetchDataFirstTime {
                VStack {
                    ProgressView()
                        .scaleEffect(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(0.3))
            }
        }
        .navigationTitle("Your subscriptions")
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
        .onAppear {
            Task {
                if !viewModel.didFetchDataFirstTime {
                    await viewModel.reloadSubscriptions()
                }
            }
        }
    }
}

#Preview {
    MasterPreview()
}
