//
//  FlightSearchCoordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class FlightSearchCoordinator {

    private let navigationController: UINavigationController = {
        let navigationController = NoBackTitleNavigationController()

        let navigationBar = navigationController.navigationBar
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = .charcoalGrey

        return navigationController
    }()

    private var hasStarted = false

    private func flightSearchQueryScreen() -> UIViewController {
        let view: FlightSearchQueryViewController = UIViewController.instantiateFromStoryboard()
        view.findFlights = { [weak self] searchQuery, localizationPreferences in
            guard let self = self else {
                return
            }
            let nextViewController = self.flightSearchResultsList(searchQuery: searchQuery,
                                                                  localizationPreferences: localizationPreferences)
            self.navigationController.pushViewController(nextViewController, animated: true)
        }
        return view
    }

    private func flightSearchResultsList(searchQuery: FlightSearchQuery, localizationPreferences: LocalizationPreferences) -> UIViewController {
        let view: FlightSearchResultsListViewController = UIViewController.instantiateFromStoryboard()
        let interactor = FlightSearchResultsListInteractor(repository: FlightSearchRepository(apiClient: FlightSearchAPIClient()))
        let presenter = FlightSearchResultsListPresenter(view: view,
                                                         interactor: interactor,
                                                         searchQuery: searchQuery,
                                                         localizationPreferences: localizationPreferences)
        view.presenter = presenter

        return view
    }
}

extension FlightSearchCoordinator: Coordinator {
    func start() {
        hasStarted = true
        navigationController.viewControllers = [flightSearchQueryScreen()]
    }
}

extension FlightSearchCoordinator: TabCompatibleCoordinator {
    var viewControllerForTabBar: UIViewController {
        if !hasStarted {
            start()
        }
        return navigationController
    }

    var imageForTabBarItem: UIImage? {
        return #imageLiteral(resourceName: "search")
    }
}
