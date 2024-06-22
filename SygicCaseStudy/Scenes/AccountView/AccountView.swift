//
//  AccountViewView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI
import GoogleSignIn

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if viewModel.user.profile?.hasImage ?? false {
                    AsyncImage(url: viewModel.user.profile?.imageURL(withDimension: UInt(UIScreen.main.bounds.width) / 3))
                        .padding()
                }
                Text(viewModel.user.profile?.name ?? "Name couldn't be retrieved")
                    .foregroundStyle(.white)
                    .font(.title)
                Text(viewModel.user.profile?.email ?? "Email couldn't be retrieved")
                    .foregroundStyle(.white)
                    .font(.subheadline)
            }
            Spacer()
            Button(
                action: {
                    viewModel.logout()
                },
                label: {
                    Text("Logout")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(.accentRed)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(color: .black, radius: 3)
                }
            )
            .padding()
        }
    }
}

#Preview {
    AppBackground {
        AccountView(viewModel: AccountViewModel(coordinator: RootCoordinator(), user: GIDGoogleUser()))
    }
}
