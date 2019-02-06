//
//  FlightSearchResultViewModelMapper.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

enum FlightSearchResultViewModelMapper {

    static func from(response: FlightSearchResponse) -> [FlightSearchResultViewModel] {
        let currency = response.currency
        let locale = Locale(identifier: currency.locale)

        let currencyFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = currency.currencyCode
            formatter.locale = locale
            return formatter
        }()

        let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = locale
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()

        let durationFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.hour, .minute]
            return formatter
        }()

        return response.results.map { result -> FlightSearchResultViewModel in
            let itinerary = result.itinerary

            let outboundLegViewModel = FlightLegViewModelMapper.from(leg: itinerary.outboundLeg,
                                                                     timeFormatter: timeFormatter,
                                                                     durationFormatter: durationFormatter)
            let inboundLegViewModel: FlightLegViewModel?
            if let inboundLeg = itinerary.inboundLeg {
                inboundLegViewModel = FlightLegViewModelMapper.from(leg: inboundLeg,
                                                                    timeFormatter: timeFormatter,
                                                                    durationFormatter: durationFormatter)
            } else {
                inboundLegViewModel = nil
            }

            let price = currencyFormatter.string(from: NSDecimalNumber(decimal: itinerary.price)) ?? ""

            let flags = [
                result.isCheapest ? "Cheapest" : "",
                result.isShortest ? "Shortest" : "",
                ]
                .joined(separator: " ")

            return FlightSearchResultViewModel(outboundLeg: outboundLegViewModel, inboundLeg: inboundLegViewModel, price: price, flags: flags)
        }
    }
}

private enum FlightLegViewModelMapper {

    private enum Constants {
        static let carrierLogoTemplate = "https://logos.skyscnr.com/images/airlines/favicon/%@.png"
    }

    static func from(leg: Leg, timeFormatter: DateFormatter, durationFormatter: DateComponentsFormatter) -> FlightLegViewModel {
        let carrierImageURL = URL(string: String(format: Constants.carrierLogoTemplate, leg.carrier.code))
        let carrierName = leg.carrier.name
        let departureTime = timeFormatter.string(from: leg.departureDateTime)
        let arrivalTime = timeFormatter.string(from: leg.arrivalDateTime)
        let places = [leg.departurePlace.code, leg.arrivalPlace.code].joined(separator: "-")
        let segments = leg.segments < 2 ? "Direct" : "\(leg.segments) stops"
        let duration = durationFormatter.string(from: Double(leg.durationMinutes) * 60.0) ?? ""

        return FlightLegViewModel(carrierImageURL: carrierImageURL,
                                  times: "\(departureTime) - \(arrivalTime)",
                                  places: "\(places), \(carrierName)",
                                  segments: segments,
                                  duration: duration)
    }
}
