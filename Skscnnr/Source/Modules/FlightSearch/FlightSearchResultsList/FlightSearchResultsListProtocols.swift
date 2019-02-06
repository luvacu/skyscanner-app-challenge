//
//  FlightSearchResultsListProtocols.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import RxSwift

protocol FlightSearchResultsListViewProtocol: class {
    var presenter: FlightSearchResultsListPresenterProtocol! { get set }

    func showNoResultsYet()
    func showResults(_ viewModels: [FlightSearchResultViewModel], totalCount: String)
    func showLoadingSpinner()
    func hideLoadingSpinner()
    func showError()
}

protocol FlightSearchResultsListPresenterProtocol {
    var queryPlaces: String { get }
    var queryDates: String { get }
    
    func viewDidLoad()
    func viewDidAppear()
    func viewWillDisappear()
}

protocol FlightSearchResultsListInteractorProtocol {
    func searchFlights(searchQuery: FlightSearchQuery, localizationPreferences: LocalizationPreferences) -> Observable<FlightSearchResponse>
}

enum FlightSearchError: Error {
    /// Provided adults parameter is out of valid range
    case adultsOutOfRange(validRange: ClosedRange<Int>, input: Int)
}
