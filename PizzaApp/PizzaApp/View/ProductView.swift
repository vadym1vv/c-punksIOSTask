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
    @State private var selectedPizzaSize: PizzaVariant? = nil
    
    var currentPizza: Pizza? {
        if (!contentViewModel.pizza.isEmpty && contentViewModel.pizza.count > currentPizzaIndex) {
            return contentViewModel.pizza[currentPizzaIndex]
        } else {
            return nil
        }
    }
    
    var defaultPizzaVariant: PizzaVariant? {
        guard let defaultSize = currentPizza?.defaultSize, let defaultVariant = currentPizza?.variants?.first(where: {$0.size.rawValue == defaultSize.rawValue}) else {
            return nil
        }
        return defaultVariant
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let pizza = currentPizza?.name {
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
                
                if let currentPizza {
                    ProductDetailsComponent(price: selectedPizzaSize?.price ?? defaultPizzaVariant?.price, pizza: currentPizza)
                }
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
