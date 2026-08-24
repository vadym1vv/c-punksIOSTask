//
//  ContentViewModel.swift
//  PizzaApp
//
//  Created by Vadym Vasylaki on 24.08.2026.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var pizza: [Pizza] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var service: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    init(service: NetworkService = NetworkManager.shared) {
        self.service = service
    }
    
    func fetchPizzas() {
            self.isLoading = true
            
            service.fetch(endpoint: .pizzas, type: PizzaResponse.self)
                .flatMap { response -> AnyPublisher<PizzaResponse, Error> in
                    let urls = response.pizzas.compactMap { $0.imageURL }
                    return ImagePreloader.shared.preload(urls: urls)
                        .setFailureType(to: Error.self)
                        .map { response }
                        .eraseToAnyPublisher()
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    self?.handleCompletion(completion)
                } receiveValue: { [weak self] response in
                    self?.pizza = response.pizzas
                }
                .store(in: &cancellables)
        }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        self.isLoading = false
        if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
        }
    }
}
