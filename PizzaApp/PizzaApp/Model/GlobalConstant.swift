//
//  GlobalConstant.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation

struct GlobalConstant {
    
    static let mocSinglePizza = Pizza(id: "midnight-harvest", name: "Midnight Harvest", description: "This pizza celebrates the rich and bold flavors of black olives paired with a medley of cheeses. The deep, earthy taste of black olives harmonizes beautifully with the creamy, melted cheeses.", imageURL: URL(string: "https://oursongapp.com/images/pizzas/pizza_midnight_harvest.png"), variants: [PizzaVariant(size: .small, price: 14.99), PizzaVariant(size: .medium, price: 17.99), PizzaVariant(size: .large, price: 21.99)], defaultSize: .medium)
}
