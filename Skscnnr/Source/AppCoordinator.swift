//
//  AppCoordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let childCoordinators: [TabCompatibleCoordinator]
    private let tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()

        let tabBar = tabBarController.tabBar
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = .turquoiseBlue
        tabBar.unselectedItemTintColor = .purpleyGrey

        let layer = tabBar.layer
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3

        return tabBarController
    }()

    init(window: UIWindow) {
        self.window = window
        self.childCoordinators = [ExploreCoordinator(), FlightSearchCoordinator(), UserProfileCoordinator()]
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        tabBarController.viewControllers = childCoordinators.map { coordinator in
            let viewController = coordinator.viewControllerForTabBar
            viewController.tabBarItem = UITabBarItem(title: nil, image: coordinator.imageForTabBarItem, tag: 0)
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            return viewController
        }
        tabBarController.selectedIndex = 1
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
