//
//  Dictionary+Append.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

extension Dictionary {
    static func +(left: Dictionary, right: Dictionary) -> Dictionary {
        return left.merging(right) { (current, _) in current }
    }

    static func +=(left: inout Dictionary, right: Dictionary) {
        left.merge(right) { (current, _) in current }
    }
}
