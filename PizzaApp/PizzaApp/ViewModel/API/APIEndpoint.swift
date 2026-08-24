//
//  APIEndpoint.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import Combine

enum APIEndpoint {
    case pizzas
    
    var baseURL: String {
        return "https://oursongapp.com/api"
    }
    
    var path: String {
        switch self {
        case .pizzas: return "/pizzas"
        }
    }
    
    var url: URL? {
        URL(string: baseURL + path)
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

protocol NetworkService {
    func fetch<T: Decodable>(endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
