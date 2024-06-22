//
//  LoadingView.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 22/06/2024.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    var content: () -> Content
    @Binding var isShown: Bool

    init(@ViewBuilder content: @escaping () -> Content, isShown: Binding<Bool>) {
        self.content = content
        self._isShown = isShown
    }

    var body: some View {
        ZStack {
            content()
            if isShown {
                VStack {
                    ProgressView()
                        .scaleEffect(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(0.3))
            }
        }

    }
}
