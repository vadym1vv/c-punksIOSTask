//
//  ProductDetailsComponent.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct ProductDetailsComponent: View {
    
    var price: Double?
    
    var pizza: Pizza
    
    @State private var selectedNumberOfProduct: Int = 1
    
    var body: some View {
        VStack {
            if let price {
                if let description = pizza.description {
                    Text(description)
                        .font(FontEnum.regular14.font)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .padding(.vertical)
                }
                
                HStack {
                    
                    HStack(spacing: 0) {
                        Text("\(selectedNumberOfProduct)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .frame(width: 130, height: 45)
                            .background(ColorEnum.highlight.color)
                            .clipShape(Capsule())
                    }
                    .background(ColorEnum.highlight.color)
                    .clipShape(Capsule())
                    .overlay(alignment: .leading) {
                        Button {
                            if (selectedNumberOfProduct > 1) {
                                selectedNumberOfProduct -= 1
                            }
                        } label: {
                            CircularButtonLabel(content: Image(IconEnum.minus.rawValue))
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            if (selectedNumberOfProduct < 100){
                                selectedNumberOfProduct += 1
                            }
                        } label: {
                            CircularButtonLabel(content: Image(IconEnum.plus.rawValue))
                        }
                    }
                    
                    Text("$\(String(format: "%.2f", Double(selectedNumberOfProduct) * price))")
                        .frame(maxWidth: .infinity)
                    Button {
                        
                    } label: {
                        Text("Add")
                            .frame(width: 83, height: 48)
                            .background(ColorEnum.accent.color)
                            .clipShape(RoundedRectangle(cornerRadius: 36))
                            .foregroundStyle(ColorEnum.bg.color)
                    }
                }
                .font(FontEnum.extrabold24.font)
            }
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(ColorEnum.active.color)
    }
}

#Preview {
    VStack {
        Spacer()
        ProductDetailsComponent(price: 17.99, pizza: GlobalConstant.mocSinglePizza)
            .padding(.horizontal)
    }
    .background(ColorEnum.bg.color)
}
