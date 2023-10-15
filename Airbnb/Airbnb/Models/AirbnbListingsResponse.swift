//
//  AirbnbListingsResponse.swift
//  Airbnb
//
//  Created by Michael Kan on 2023/10/15.
//

import Foundation

struct AirbnbListingsResponse: Codable {
    let total_count: Int
    let results: [AirbnbListing]
}
