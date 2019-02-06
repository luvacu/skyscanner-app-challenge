//
//  FlightSearchResultViewModel.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

struct FlightSearchResultViewModel {
    let outboundLeg: FlightLegViewModel
    let inboundLeg: FlightLegViewModel?
    let price: String
    let flags: String
}

struct FlightLegViewModel {
    let carrierImageURL: URL?
    let times: String
    let places: String
    let segments: String
    let duration: String
}
