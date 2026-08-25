//
//  PreloaderView.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct PreloaderView: View {
    
    @StateObject private var contentViewModel: ContentViewModel = ContentViewModel()
    
    @State private var revealedSlice = 0
    @State private var navigateToProduct = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image(IconEnum.preloaderImg.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 1.5)

                GeometryReader { geometry in
                    let size = min(geometry.size.width, geometry.size.height)

                    ZStack {
                        ForEach(0..<8, id: \.self) { index in
                            PizzaSlice(
                                startAngle: .degrees(
                                    Double(index) * 45 - 90
                                ),
                                endAngle: .degrees(
                                    Double(index + 1) * 45 - 90
                                )
                            )
                            .fill(ColorEnum.bg.color)
                            .opacity(index >= revealedSlice ? 1 : 0)
                        }
                    }
                    .frame(width: size, height: size)
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height / 2
                    )
                }
            }
            .frame(
                width: UIScreen.main.bounds.width / 1.5,
                height: UIScreen.main.bounds.width / 1.5
            )
            .navigationDestination(isPresented: $navigateToProduct) {
                ProductView(contentViewModel: contentViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                contentViewModel.fetchPizzas()
                animateSlices()
            }
        }
    }

    private func animateSlices() {
        revealedSlice = 0

        for index in 1...8 {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Double(index) * 0.15
            ) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    revealedSlice = index
                }
                
                if index == 8 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        if contentViewModel.isLoading {
                            animateSlices()
                        } else {
                            navigateToProduct = true
                        }
                    }
                }
            }
        }
    }
}

struct PizzaSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(
            x: rect.midX,
            y: rect.midY
        )

        let radius = max(
            rect.width,
            rect.height
        ) / 2

        var path = Path()

        path.move(to: center)

        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )

        path.closeSubpath()

        return path
    }
}

#Preview {
    PreloaderView()
}
