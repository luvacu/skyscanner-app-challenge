//
//  AppCoordinator.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
    }
}
