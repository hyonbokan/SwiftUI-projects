//
//  AirbnbListingsViewViewModel.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/16.
//

import Foundation

final class AirbnbListingsViewViewModel: ObservableObject {
    private let service = APIService()
    
    @Published var listrings: [AirbnbListing] = []
    
    public func fetchListring() {
        service.getListings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.listrings = models
                case .failure:
                    break
                }
            }
        }
    }
}
