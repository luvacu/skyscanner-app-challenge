//
//  Coordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 03/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

protocol TabCompatibleCoordinator: Coordinator {
    var viewControllerForTabBar: UIViewController { get }
    var imageForTabBarItem: UIImage? { get }
}
