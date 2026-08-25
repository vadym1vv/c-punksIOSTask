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
                            insertion: .move(edge: .top),
                            removal: .move(edge: .top)
                        )
                    )
            }

            HStack {
                if isVisible {
                    leadingView
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .leading)
                            )
                        )
                }

                Spacer()

                if isVisible {
                    trailingView
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .trailing)
                            )
                        )
                }
            }
            .padding()
        }
        .animation(.bouncy, value: isVisible)
    }
}

#Preview {
    VStack {
        TopBarNavigationComponent(isVisible: false, leadingView: Text("Leading text"), centerView: Text("lorem")
            .frame(maxWidth: .infinity), trailingView: Text("Trailing text"))
        Spacer()
    }
}

