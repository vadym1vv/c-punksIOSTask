//
//  CircularButtonLabel.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

struct CircularButtonLabel<Content: View> : View{
    
    var backgroundEnum: ColorEnum = .bg
    var foregroundStyleEnum: ColorEnum = .active
    var size: CGFloat = 44
    var showShadow: Bool = true
    var showBorder: Bool = false
    var content: Content
    
    var body: some View {
        VStack {
            content
                .foregroundStyle(foregroundStyleEnum.color)
        }
        .frame(width: size, height: size)
        .background(backgroundEnum.color)
        .clipShape(Circle())
        .overlay {
            if (showBorder) {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(ColorEnum.bg.color)
            }
        }
        .shadow(
            color: showShadow ? ColorEnum.shadowColor.color : Color.clear,
              radius: 8,
              x: 0,
              y: 2
          )
    }
}

#Preview {
    VStack {
        CircularButtonLabel(content: Image(IconEnum.arrowLeft.rawValue))
        VStack {
            CircularButtonLabel(backgroundEnum: .active, foregroundStyleEnum: .bg, showShadow: false, showBorder: true,  content: Text("M")
                .font(FontEnum.semibold18.font))
        }
        .background(.black)
    }
}
