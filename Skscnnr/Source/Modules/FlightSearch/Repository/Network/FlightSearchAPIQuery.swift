//
//  FlightSearchPricingQuery.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

struct FlightSearchAPIQuery {
    let country: String
    let currency: String
    let locale: String
    let originPlace: String
    let destinationPlace: String
    let locationSchema: String
    let outboundDate: Date
    let inboundDate: Date?
    let adults: Int

    init(country: String,
         currency: String,
         locale: String,
         originPlace: String,
         destinationPlace: String,
         locationSchema: String,
         outboundDate: Date,
         inboundDate: Date?,
         adults: Int) {
        self.country = country
        self.currency = currency
        self.locale = locale
        self.originPlace = originPlace
        self.destinationPlace = destinationPlace
        self.locationSchema = locationSchema
        self.outboundDate = outboundDate
        self.inboundDate = inboundDate
        self.adults = adults
    }
}

extension FlightSearchAPIQuery: Encodable {

    func asParameters() -> [String: Any]? {
        guard let data = try? newJSONEncoder().encode(self),
            let parameters = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
        }
        return parameters
    }

    private func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        encoder.dateEncodingStrategy = .formatted(FlightSearchAPIQuery.dateFormatter)
        return encoder
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
