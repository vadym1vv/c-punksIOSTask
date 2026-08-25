//
//  TopBarNavigationComponent.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import SwiftUI

struct TopBarNavigationComponent<
    LeadingView: View,
    CenterView: View,
    TrailingView: View
>: View {
    
    let isVisible: Bool
    
    let leadingView: LeadingView
    let centerView: CenterView
    let trailingView: TrailingView
    
    var body: some View {
        ZStack {
            if isVisible {
                centerView
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        )
                    )
            }
            
            HStack {
                if isVisible {
                    leadingView
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .leading).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            )
                        )
                }
                
                Spacer()
                
                if isVisible {
                    trailingView
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            )
                        )
                }
            }
            .padding()
        }
        .animation(.snappy(duration: 0.25), value: isVisible)
    }
}

#Preview {
    VStack {
        TopBarNavigationComponent(isVisible: false, leadingView: Text("Leading text"), centerView: Text("lorem")
            .frame(maxWidth: .infinity), trailingView: Text("Trailing text"))
        Spacer()
    }
}
