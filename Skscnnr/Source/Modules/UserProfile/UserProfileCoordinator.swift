//
//  UserProfileCoordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class UserProfileCoordinator {

}

extension UserProfileCoordinator: Coordinator {
    func start() {

    }
}

extension UserProfileCoordinator: TabCompatibleCoordinator {
    var viewControllerForTabBar: UIViewController {
        let viewController: UserProfileViewController = UIViewController.instantiateFromStoryboard()
        return viewController
    }

    var imageForTabBarItem: UIImage? {
        return #imageLiteral(resourceName: "profile")
    }
}
