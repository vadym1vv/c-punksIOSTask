//
//  PizzaAppApp.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import SwiftUI

@main
struct PizzaAppApp: App {
    
    init() {
        URLCache.shared = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ProductView()
        }
    }
}
