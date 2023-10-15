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
}
