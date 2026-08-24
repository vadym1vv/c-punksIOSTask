//
//  TopBarNavigationComponent.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation

import SwiftUI

struct TopBarNavigationComponent<LeadingView: View, CenterView: View, TrailingView: View>: View {
    
    var leadingView: LeadingView
    var centerView: CenterView
    var trailingView: TrailingView
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack {
                    centerView
                        .padding(.horizontal, UIScreen.main.bounds.width / 7)
                    HStack {
                        leadingView
                        Spacer()
                        trailingView
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    VStack {
        TopBarNavigationComponent(leadingView: Text("Leading text"), centerView: Text("lorem")
            .frame(maxWidth: .infinity), trailingView: Text("Trailing text"))
        Spacer()
    }
}

