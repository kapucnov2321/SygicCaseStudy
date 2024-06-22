//
//  RootView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var viewModel: InitialViewModel

    var body: some View {
        VStack {
            Image("youtubeLogo")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: UIScreen.main.bounds.width/1.8)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.checkIfSignedIn()
                    }
                }
            Text("YouTube Stats")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    InitialView(viewModel: InitialViewModel(coordinator: RootCoordinator()))
}
