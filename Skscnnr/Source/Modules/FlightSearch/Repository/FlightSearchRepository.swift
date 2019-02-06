//
//  FlightSearchRepository.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import RxSwift

struct FlightSearchRepository {

    private enum Constants {
        static let skyLocationSchema = "sky"
    }

    private let apiClient: FlightSearchAPIClient

    init(apiClient: FlightSearchAPIClient) {
        self.apiClient = apiClient
    }

    func fetchLivePricing(searchQuery: FlightSearchQuery, localizationPreferences: LocalizationPreferences) -> Observable<([Itinerary], Currency)> {
        return Observable.deferred {
                let query = FlightSearchAPIQuery(country: localizationPreferences.country,
                                                    currency: localizationPreferences.currency,
                                                    locale: localizationPreferences.locale,
                                                    originPlace: searchQuery.origin.withLocationSchema(Constants.skyLocationSchema),
                                                    destinationPlace: searchQuery.destination.withLocationSchema(Constants.skyLocationSchema),
                                                    locationSchema: Constants.skyLocationSchema,
                                                    outboundDate: searchQuery.outboundDate,
                                                    inboundDate: searchQuery.inboundDate,
                                                    adults: searchQuery.adults)
                return .just(query)
            }
            .flatMap { self.apiClient.fetchLivePricing(query: $0) }
            .observeOn(SerialDispatchQueueScheduler(qos: .userInitiated))
            .map(FlightSearchAPIResponseMapper.toItinerariesAndCurrency)
    }
}

private extension FlightPlaces {

    func withLocationSchema(_ locationSchema: String) -> String {
        let string: String
        switch self {
        case .edi:
            string = "EDI"
        case .lhr:
            string = "LHR"
        }
        return [string, locationSchema].joined(separator: "-")
    }
}
