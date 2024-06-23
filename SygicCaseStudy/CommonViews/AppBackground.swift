//
//  AppBackground.swift
//  SygicCaseStudy
//
//  Created by Ján Matoniak on 21/06/2024.
//

import SwiftUI

struct AppBackground: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: .accentGray, location: 0),
                    Gradient.Stop(color: .accentBlack, location: 0.8)
                ]),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            GeometryReader { reader in
                Triangle()
                    .fill(
                        LinearGradient(
                        gradient: Gradient(stops: [
                            Gradient.Stop(color: .accentGray, location: 0),
                            Gradient.Stop(color: .accentBlack, location: 0.5),
                            Gradient.Stop(color: .accentBlack, location: 1)

                        ]),
                        startPoint: .bottomTrailing,
                        endPoint: .topLeading
                    ))
                    .frame(width: reader.size.width, height: reader.size.height / 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            content
        }

    }
}

#Preview {
    VStack {
        
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .modifier(AppBackground())
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}
