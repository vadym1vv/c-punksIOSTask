//
//  ColorEnum.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import SwiftUI

enum ColorEnum: String {
    case accent, active, bg, highlight, shadowColor
    
    var color: Color {
        return Color(self.rawValue)
    }
}
