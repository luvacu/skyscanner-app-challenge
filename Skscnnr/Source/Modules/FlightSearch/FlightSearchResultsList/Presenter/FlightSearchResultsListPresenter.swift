//
//  FlightSearchResultsListPresenter.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import RxSwift

final class FlightSearchResultsListPresenter {

    private weak var view: FlightSearchResultsListViewProtocol?
    private let interactor: FlightSearchResultsListInteractorProtocol
    private let searchQuery: FlightSearchQuery
    private let localizationPreferences: LocalizationPreferences
    private let dateFormatter: DateFormatter

    private var disposeBag = DisposeBag()

    init(view: FlightSearchResultsListViewProtocol,
         interactor: FlightSearchResultsListInteractorProtocol,
         searchQuery: FlightSearchQuery,
         localizationPreferences: LocalizationPreferences) {
        self.view = view
        self.interactor = interactor
        self.searchQuery = searchQuery
        self.localizationPreferences = localizationPreferences
        self.dateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: localizationPreferences.locale)
            formatter.setLocalizedDateFormatFromTemplate("MMMddEEE")
            return formatter
        }()
    }
}

extension FlightSearchResultsListPresenter: FlightSearchResultsListPresenterProtocol {

    var queryPlaces: String {
        return "\(searchQuery.origin) to \(searchQuery.destination)"
    }

    var queryDates: String {
        return [searchQuery.outboundDate, searchQuery.inboundDate]
            .compactMap { date in
                guard let date = date else {
                    return nil
                }
                return dateFormatter.string(from: date)
            }
            .joined(separator: " – ")
    }

    func viewDidLoad() {
        view?.showNoResultsYet()
    }

    func viewDidAppear() {
        view?.showLoadingSpinner()
        interactor.searchFlights(searchQuery: searchQuery, localizationPreferences: localizationPreferences)
            .map(FlightSearchResultViewModelMapper.from(response:))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewModels in
                self?.view?.showResults(viewModels, totalCount: "\(viewModels.count) results shown")
            }, onError: { [weak self] error in
                self?.view?.hideLoadingSpinner()
                self?.view?.showError()
            }, onCompleted: { [weak self] in
                self?.view?.hideLoadingSpinner()
            })
            .disposed(by: disposeBag)
    }

    func viewWillDisappear() {
        disposeBag = DisposeBag()
    }
}
