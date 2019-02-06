//
//  NoBackTitleNavigationController.swift
//  Skscnnr
//
//  Created by Luis Valdés on 03/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class NoBackTitleNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension NoBackTitleNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButtonItem
    }
}
