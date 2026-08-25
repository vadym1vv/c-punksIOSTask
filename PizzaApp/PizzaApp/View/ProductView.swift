//
//  ProductView.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct ProductView: View {
    
    @ObservedObject var contentViewModel: ContentViewModel
    
    @State private var currentPizzaIndex: Int = 0
    @State private var selectedPizzaSize: PizzaSize? = .medium
    @State private var isFullScreen: Bool = false
    @State private var animateOnAppear: Bool = false
    
    var currentPizza: Pizza? {
        if (!contentViewModel.pizza.isEmpty && contentViewModel.pizza.count > currentPizzaIndex) {
            return contentViewModel.pizza[currentPizzaIndex]
        } else {
            return nil
        }
    }
    
    var selectedPizzaVariant: PizzaVariant? {
        let currentSize = selectedPizzaSize ?? currentPizza?.defaultSize
        return currentPizza?.variants?.first(where: {$0.size == currentSize})
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if animateOnAppear {
                if let pizza = currentPizza?.name {
                    
                    VStack {
                        ZStack(alignment: .top) {
                            TopBarNavigationComponent(
                                isVisible: !isFullScreen,
                                
                                leadingView: Button {
                                } label: {
                                    CircularButtonLabel(
                                        content: Image(IconEnum.arrowLeft.rawValue)
                                    )
                                },
                                
                                centerView: VStack(spacing: 0) {
                                    Text("Pizzas")
                                        .font(FontEnum.regular10.font)
                                    
                                    Text(pizza)
                                        .font(FontEnum.semibold24.font)
                                },
                                
                                trailingView: Button {
                                } label: {
                                    CircularButtonLabel(
                                        content: Image(IconEnum.selected.rawValue)
                                    )
                                }
                            )
                        }
                    }
                    
                    if !isFullScreen {
                        Spacer()
                    }
                    
                    PizzaImgPreviewComponent(
                        currentIndex: $currentPizzaIndex,
                        isFullScreen: $isFullScreen,
                        selectedPizzaSize: selectedPizzaSize, contentViewModel: contentViewModel
                    )
                    .padding(.bottom)
                    
                    if !isFullScreen {
                        Spacer()
                    }
                
                    if !isFullScreen {
                        Image(IconEnum.bananaForScale.rawValue)
                            .padding(.bottom)
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .opacity.combined(with: .move(edge: .bottom))
                                )
                            )
                    }
                }
              
                if let currentPizza, !isFullScreen {
                    ProductDetailsComponent(price: selectedPizzaVariant?.price, pizza: currentPizza)
                        .frame(height: UIScreen.main.bounds.height / 3)
                        .padding()
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.bouncy, value: isFullScreen)
        .foregroundStyle(ColorEnum.active.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ZStack(alignment: .top) {
            ColorEnum.bg.color
            
            Circle()
                .overlay(alignment: .bottom) {
                    HStack(spacing: 0) {
                        if !isFullScreen && animateOnAppear {
                            HStack(spacing: 0) {
                                Button {
                                    withAnimation {
                                        selectedPizzaSize = .small
                                    }
                                } label: {
                                    CircularButtonLabel(backgroundEnum: selectedPizzaSize == .small ? ColorEnum.active : ColorEnum.bg, foregroundStyleEnum: selectedPizzaSize == .small ? ColorEnum.bg : ColorEnum.active, showShadow: selectedPizzaSize == .small ? false : true, showBorder: selectedPizzaSize == .small ? true : false, content: Text("S")
                                        .font(FontEnum.semibold18.font)
                                    )
                                }
                                .offset(x: -70)
                                Button {
                                    withAnimation {
                                        selectedPizzaSize = .medium
                                    }
                                } label: {
                                    CircularButtonLabel(backgroundEnum: selectedPizzaSize == .medium ? ColorEnum.active : ColorEnum.bg, foregroundStyleEnum: selectedPizzaSize == .medium ? ColorEnum.bg : ColorEnum.active, showShadow: selectedPizzaSize == .medium ? false : true, showBorder: selectedPizzaSize == .medium ? true : false, content: Text("M")
                                        .font(FontEnum.semibold18.font)
                                    )
                                }
                                .offset(y: 15)
                                
                                Button {
                                    withAnimation {
                                        selectedPizzaSize = .large
                                    }
                                } label: {
                                    CircularButtonLabel(backgroundEnum: selectedPizzaSize == .large ? ColorEnum.active : ColorEnum.bg, foregroundStyleEnum: selectedPizzaSize == .large ? ColorEnum.bg : ColorEnum.active, showShadow: selectedPizzaSize == .large ? false : true, showBorder: selectedPizzaSize == .large ? true : false, content: Text("L")
                                        .font(FontEnum.semibold18.font)
                                    )
                                }
                                .offset(x: 70)
                            }
                            .transition(.move(edge: .bottom))
                        }
                    }
                    .animation(.bouncy, value: isFullScreen)
                }
                .frame(width: 607, height: 607)
                .foregroundStyle(ColorEnum.highlight.color)
                .offset(y: -150)
                .zIndex(1)
            
        })
        .ignoresSafeArea(edges: isFullScreen ? .all : [])
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.bouncy) {
                    animateOnAppear = true
                }
            }
        }
        .onChange(of: currentPizzaIndex) { oldValue, newValue in
            selectedPizzaSize = contentViewModel.pizza[newValue].defaultSize
        }
    }
}

#Preview {
    ProductView(contentViewModel: ContentViewModel())
}
