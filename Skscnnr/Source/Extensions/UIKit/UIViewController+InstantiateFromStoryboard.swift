//
//  UIViewController+InstantiateFromStoryboard.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromStoryboard<T>(storyboardName: String = "\(T.self)", identifier: String = "\(T.self)") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to find a ViewController with identifier \(identifier) of type \(T.self)")
        }
        return viewController
    }
}
