//
//  PizzaResponse.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation

struct PizzaResponse: Codable {
    let pizzas: [Pizza]
}

struct Pizza: Codable, Identifiable {
    let id: String
    let name: String?
    let description: String?
    let imageURL: URL?
    let variants: [PizzaVariant]?
    let defaultSize: PizzaSize?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
        case variants
        case defaultSize = "default_size"
    }
}

struct PizzaVariant: Codable, Identifiable {
    let size: PizzaSize
    let price: Double

    var id: String {
        size.rawValue
    }
}

enum PizzaSize: String, Codable, CaseIterable {
    case small = "S"
    case medium = "M"
    case large = "L"
}
