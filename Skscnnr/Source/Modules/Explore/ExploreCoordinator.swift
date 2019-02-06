//
//  ExploreCoordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class ExploreCoordinator {

}

extension ExploreCoordinator: Coordinator {
    func start() {

    }
}

extension ExploreCoordinator: TabCompatibleCoordinator {
    var viewControllerForTabBar: UIViewController {
        let viewController: ExploreViewController = UIViewController.instantiateFromStoryboard()
        return viewController
    }

    var imageForTabBarItem: UIImage? {
        return #imageLiteral(resourceName: "explore")
    }
}
