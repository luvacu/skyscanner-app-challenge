//
//  Date+AddingComponent.swift
//  Skscnnr
//
//  Created by Luis Valdés on 03/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

extension Date {
    func adding(_ value: Int, component: Calendar.Component) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
}
