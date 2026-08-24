//
//  ProductView.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct ProductView: View {
    @StateObject private var contentViewModel: ContentViewModel = ContentViewModel()
    
    @State private var currentPizzaIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            if !contentViewModel.pizza.isEmpty, let pizza = contentViewModel.pizza[currentPizzaIndex].name {
                TopBarNavigationComponent(
                    leadingView:
                        Button {} label: {
                            CircularButtonLabel(content: Image(IconEnum.arrowLeft.rawValue))
                        },
                    centerView:
                        VStack (spacing: 0) {
                            Text("Pizzas")
                                .font(FontEnum.regular10.font)
                            
                            Text(pizza)
                                .font(FontEnum.semibold24.font)
                        }
                    ,
                    trailingView:
                        Button {} label: {
                            CircularButtonLabel(content: Image(IconEnum.selected.rawValue))
                        }
                )
                PizzaImgPreviewComponent(currentIndex: $currentPizzaIndex, contentViewModel: contentViewModel)
            }
        }
        .foregroundStyle(ColorEnum.active.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorEnum.highlight.color)
        .onAppear {
            contentViewModel.fetchPizzas()
        }
    }
}

#Preview {
    ProductView()
}
