//
//  FlightPlaces.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

enum FlightPlaces: CustomStringConvertible {
    case lhr
    case edi

    var description: String {
        switch self {
        case .lhr:
            return "London"
        case .edi:
            return "Edinburgh"
        }
    }
}
