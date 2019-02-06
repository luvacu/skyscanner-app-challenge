//
//  UITableView+DequeueReusableCell.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T {
        let identifier = "\(T.self)"
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Failed to deuque a TableViewCell with idenifier \(identifier) of type \(T.self)")
        }
        return cell
    }
}
