//
//  FontEnum.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import SwiftUI

enum FontEnum: CaseIterable {
    
    case semibold24, semibold18, regular14, regular10, extrabold24
    
    var font: Font {
        switch self {
        case .semibold24:
            return Font.custom("Figtree-SemiBold", fixedSize: 24)
        case .semibold18:
            return Font.custom("Figtree-SemiBold", fixedSize: 18)
        case .regular14:
            return Font.custom("Figtree-Regular", size: 14)
        case .regular10:
            return Font.custom("Figtree-Regular", size: 10)
        case .extrabold24:
            return Font.custom("Figtree-ExtraBold", size: 24)
        }
    }
}

struct FontEnum_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollView {
                ForEach(FontEnum.allCases, id: \.self) { font in
                    Text("Hello world")
                        .font(font.font)
                }
            }
        }
    }
}
