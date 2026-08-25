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
//    @State private var selectedPizzaSize: PizzaVariant? = nil
    @State private var selectedPizzaSize: PizzaSize? = .small
    @State private var isShowingDetails: Bool = false
    
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
            if let pizza = currentPizza?.name {
                
               
                    VStack {
                        ZStack(alignment: .top) {
                            TopBarNavigationComponent(
                                isVisible: isShowingDetails,

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
                        .animation(.bouncy, value: isShowingDetails)
                        PizzaImgPreviewComponent(currentIndex: $currentPizzaIndex, contentViewModel: contentViewModel)
                        Spacer()
                    }

                
                    VStack {
                        
                        if let currentPizza, isShowingDetails {
                            ProductDetailsComponent(price: selectedPizzaVariant?.price, pizza: currentPizza)
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .padding()
                                .transition(.move(edge: .bottom))
                        }
                    }
                
            }
        }
        .animation(.bouncy, value: isShowingDetails)
        .foregroundStyle(ColorEnum.active.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ZStack(alignment: .top) {
            ColorEnum.bg.color
            Circle()
                .overlay(alignment: .bottom) {
                    HStack(spacing: 0) {
                        if (isShowingDetails) {
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
                                        isShowingDetails.toggle()
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
                    .animation(.bouncy, value: isShowingDetails)
                }
               .frame(width: 607, height: 607)
               .foregroundStyle(ColorEnum.highlight.color)
               .offset(y: -150)
              
            
            VStack {
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(ColorEnum.highlight.color)
            
        })
        .background(ignoresSafeAreaEdges: .top)
        .onAppear {
            contentViewModel.fetchPizzas()
           
                isShowingDetails = true
            
        }
        .onChange(of: currentPizzaIndex) { oldValue, newValue in
            selectedPizzaSize = contentViewModel.pizza[newValue].defaultSize
        }
    }
}

#Preview {
    ProductView()
}
