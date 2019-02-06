//
//  FlightSearchResponse.swift
//  Skscnnr
//
//  Created by Luis Valdés on 04/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

struct FlightSearchResponse {
    let currency: Currency
    let results: [FlightSearchResult]
}

struct Currency {
    let currencyCode: String
    let locale: String
}

struct FlightSearchResult {
    let itinerary: Itinerary
    let isCheapest: Bool
    let isShortest: Bool
}

struct Itinerary {
    let outboundLeg: Leg
    let inboundLeg: Leg?
    let durationMinutes: Int
    let price: Decimal
}

struct Leg {
    let id: String
    let departurePlace: Place
    let arrivalPlace: Place
    let departureDateTime: Date
    let arrivalDateTime: Date
    let durationMinutes: Int
    let carrier: Carrier
    let segments: Int
}

struct Carrier {
    let id: Int
    let code: String
    let name: String
    let imageURL: String
}

struct Place {
    let id: Int
    let code: String
}
