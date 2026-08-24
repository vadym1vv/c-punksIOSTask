//
//  ImagePreloader.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import Combine

final class ImagePreloader {
    static let shared = ImagePreloader()
    
    func preload(urls: [URL]) -> AnyPublisher<Void, Never> {
        guard !urls.isEmpty else {
            return Just(()).eraseToAnyPublisher()
        }
        
        let requests = urls.map { url -> AnyPublisher<Void, Never> in
            URLSession.shared.dataTaskPublisher(for: url)
                .map { _ in () }
                .replaceError(with: ())
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(requests)
            .collect()
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
