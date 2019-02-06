//
//  FlightSearchAPIResponseMapper.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

enum FlightSearchAPIResponseMapper {

    static func toItinerariesAndCurrency(_ response: FlightSearchAPIResponse) -> ([Itinerary], Currency) {

        let placesById = response.places.reduce(into: [Int:Place]()) { result, response in
            let place = Place(id: response.id, code: response.code)
            result[place.id] = place
        }

        let carriersById = response.carriers.reduce(into: [Int:Carrier]()) { result, response in
            let carrier = Carrier(id: response.id, code: response.code, name: response.name, imageURL: response.imageURL)
            result[carrier.id] = carrier
        }

        let legsById = response.legs.reduce(into: [String:Leg]()) { result, response in
            guard let carrierId = response.carriers.first,
                let carrier = carriersById[carrierId] else {
                    return
            }
            guard let departurePlace = placesById[response.originStation],
                let arrivalPlace = placesById[response.destinationStation] else {
                    return
            }
            let leg = Leg(id: response.id,
                          departurePlace: departurePlace,
                          arrivalPlace: arrivalPlace,
                          departureDateTime: response.departure,
                          arrivalDateTime: response.arrival,
                          durationMinutes: response.duration,
                          carrier: carrier,
                          segments: response.segmentIDS.count)
            result[leg.id] = leg
        }


        let itineraries = response.itineraries.compactMap { response -> Itinerary? in
            guard let outboundLeg = legsById[response.outboundLegID] else {
                return nil
            }

            let inboundLeg: Leg?
            if let inboundLegId = response.inboundLegID {
                guard let leg = legsById[inboundLegId] else {
                    return nil
                }
                inboundLeg = leg
            } else {
                inboundLeg = nil
            }

            let duration = outboundLeg.durationMinutes + (inboundLeg?.durationMinutes ?? 0)
            let price = response.pricingOptions.min(by: { lhs, rhs in lhs.price < rhs.price })?.price ?? 0

            return Itinerary(outboundLeg: outboundLeg, inboundLeg: inboundLeg, durationMinutes: duration, price: Decimal(price))
        }

        let currency = Currency(currencyCode: response.currencies.first?.code ?? response.query.currency,
                                locale: response.query.locale)

        return (itineraries, currency)
    }
}
