//
//  PizzaImgPreview.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct PizzaImgPreviewComponent: View {
    
    @Binding var currentIndex: Int
    @ObservedObject var contentViewModel: ContentViewModel
    
    private let imageSize: CGFloat = 200
    private let sideScale: CGFloat = 0.5

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(contentViewModel.pizza) { pizza in
                    pizzaView(
                        pizza: pizza,
                        width: geometry.size.width
                    )
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .clipped()
        }
        .frame(height: imageSize)
    }

    private func pizzaView(
        pizza: Pizza,
        width: CGFloat
    ) -> some View {
        guard let index = contentViewModel.pizza.firstIndex(
            where: { $0.id == pizza.id }
        ) else {
            return AnyView(EmptyView())
        }

        let position = index - currentIndex

        guard abs(position) <= 1 else {
            return AnyView(EmptyView())
        }

        return AnyView(
            Button {
                select(index: index)
            } label: {
                URLImgComponent(url: pizza.imageURL)
                    .frame(
                        width: imageSize,
                        height: imageSize
                    )
                    .scaleEffect(
                        position == 0 ? 1 : sideScale
                    )
                    .overlay {
                        if (position == 0) {
                            Image(IconEnum.magnify.rawValue)
                        }
                    }
            }
            .buttonStyle(.plain)
            .offset(
                x: xOffset(
                    position: position,
                    width: width
                )
            )
            .zIndex(
                position == 0 ? 1 : 0
            )
            .animation(
                .easeInOut(duration: 0.35),
                value: currentIndex
            )
        )
    }

    private func xOffset(
        position: Int,
        width: CGFloat
    ) -> CGFloat {
        switch position {
        case -1:
            return -width / 2

        case 0:
            return 0

        case 1:
            return width / 2

        default:
            return 0
        }
    }

    private func select(index: Int) {
        guard contentViewModel.pizza.indices.contains(index) else {
            return
        }

        withAnimation(.easeInOut(duration: 0.35)) {
            currentIndex = index
        }
    }
}
