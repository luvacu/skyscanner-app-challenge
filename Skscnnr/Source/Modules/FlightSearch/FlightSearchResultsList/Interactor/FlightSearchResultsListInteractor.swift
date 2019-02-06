//
//  FlightSearchResultsListInteractor.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import RxSwift

final class FlightSearchResultsListInteractor {

    private enum Constants {
        static let adultsRange = 1...8
    }

    private let repository: FlightSearchRepository

    init(repository: FlightSearchRepository) {
        self.repository = repository
    }
}

extension FlightSearchResultsListInteractor: FlightSearchResultsListInteractorProtocol {

    func searchFlights(searchQuery: FlightSearchQuery, localizationPreferences: LocalizationPreferences) -> Observable<FlightSearchResponse> {
        guard Constants.adultsRange.contains(searchQuery.adults) else {
            return Observable.error(FlightSearchError.adultsOutOfRange(validRange: Constants.adultsRange, input: searchQuery.adults))
        }

        return repository.fetchLivePricing(searchQuery: searchQuery, localizationPreferences: localizationPreferences)
            .map { itineraries, currency in

                guard let cheapestPrice = itineraries.first?.price,
                    let shortestDuration = itineraries.min(by: { $0.durationMinutes < $1.durationMinutes })?.durationMinutes else {
                        return FlightSearchResponse(currency: currency, results: [])
                }

                let results = itineraries.map {
                    FlightSearchResult(itinerary: $0,
                                       isCheapest: $0.price == cheapestPrice,
                                       isShortest: $0.durationMinutes == shortestDuration)
                }
                return FlightSearchResponse(currency: currency, results: results)
            }
    }
}
