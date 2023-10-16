//
//  APIService.swift
//  Airbnb
//
//  Created by Michael Kan on 2023/10/15.
//

import Foundation

final class APIService {
    init() {}
    
    struct Constants {
        static let apiUrl = URL(string: "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/airbnb-listings/records?limit=100&lang=en&timezone=America%2FNew_York")
    }
    
    public func getListings(completion: @escaping (Result<[AirbnbListing], Error>) -> Void
    ) {
        guard let url = Constants.apiUrl else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AirbnbListingsResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                let json = try? JSONSerialization.jsonObject(with: data)
                print(String(describing: json))
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
