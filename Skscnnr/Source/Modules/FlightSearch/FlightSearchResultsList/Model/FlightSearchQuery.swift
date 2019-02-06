//
//  FlightSearchQuery.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

struct FlightSearchQuery {
    let origin: FlightPlaces
    let destination: FlightPlaces
    let outboundDate: Date
    let inboundDate: Date?
    let adults: Int
}
