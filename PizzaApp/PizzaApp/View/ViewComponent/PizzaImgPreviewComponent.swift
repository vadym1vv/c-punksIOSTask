//
//  PizzaImgPreview.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct PizzaImgPreviewComponent: View {
    
    @Binding var currentIndex: Int
    @Binding var isFullScreen: Bool
    
    let selectedPizzaSize: PizzaSize?
    
    @ObservedObject var contentViewModel: ContentViewModel
    
    private let imageSize: CGFloat = 200
    private let sideScale: CGFloat = 0.5

    var extraPixels: CGFloat {
        switch selectedPizzaSize {
        case .small: return 10
        case .medium: return 20
        case .large: return 30
        case .none: return 10
        }
    }
    
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
            .clipped(antialiased: !isFullScreen)
        }
        .frame(height: isFullScreen ? nil : imageSize)
        .frame(maxHeight: isFullScreen ? .infinity : imageSize)
        .ignoresSafeArea(edges: isFullScreen ? .all : [])
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
                if position == 0 {
                    withAnimation(.bouncy) {
                        isFullScreen.toggle()
                    }
                } else {
                    select(index: index)
                }
            } label: {
                let sizeScale: CGFloat = {
                    guard position == 0, !isFullScreen else { return 1.0 }
                    switch selectedPizzaSize {
                    case .small: return 1.0
                    case .medium: return 1.1
                    case .large: return 1.2
                    case .none: return 1.0
                    }
                }()
                let maxContainerSize = imageSize * 1.25

                URLImgComponent(url: pizza.imageURL)
                    .frame(width: imageSize, height: imageSize)
                    .scaleEffect(
                        isFullScreen && position == 0
                            ? (hypot(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / imageSize) * 1.2
                            : (position == 0 ? sizeScale : sideScale)
                    )
                    .animation(
                        position == 0 ? .spring(response: 0.35, dampingFraction: 0.3) : .none,
                        value: selectedPizzaSize
                    )
                    .opacity(isFullScreen && position != 0 ? 0 : 1)
                    .overlay {
                        if (position == 0 && !isFullScreen) {
                            Image(IconEnum.magnify.rawValue)
                        }
                    }
                    .zIndex(position == 0 ? 1 : 0)
                    .frame(
                        width: isFullScreen && position == 0 ? UIScreen.main.bounds.width : maxContainerSize,
                        height: isFullScreen && position == 0 ? UIScreen.main.bounds.height : maxContainerSize
                    )
                    .ignoresSafeArea(edges: isFullScreen && position == 0 ? .all : [])
            }
            .buttonStyle(.plain)
            .offset(x: xOffset(position: position, width: width))
            .zIndex(
                position == 0 ? 1 : 0
            )
            .animation(.bouncy, value: currentIndex)
            .animation(.bouncy, value: isFullScreen)
        )
    }

    private func xOffset(
        position: Int,
        width: CGFloat
    ) -> CGFloat {
        switch position {
        case -1: return -width / 2
        case 0: return 0
        case 1: return width / 2
        default: return 0
        }
    }

    private func select(index: Int) {
        guard contentViewModel.pizza.indices.contains(index) else { return }
        withAnimation(.easeInOut(duration: 0.35)) {
            currentIndex = index
        }
    }
}
