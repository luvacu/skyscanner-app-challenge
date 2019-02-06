//
//  NibFileOwnerLoadable.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

protocol NibFileOwnerLoadable: class {
    static var nib: UINib { get }
}

extension NibFileOwnerLoadable where Self: UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    func instantiateFromNib() -> UIView? {
        let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }

    func loadNibContent() {
        guard let view = instantiateFromNib() else {
            fatalError("Failed to instantiate nib \(Self.nib)")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let views = ["view": view]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                                 options: .alignAllLastBaseline,
                                                                 metrics: nil,
                                                                 views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                                   options: .alignAllLastBaseline,
                                                                   metrics: nil,
                                                                   views: views)
        addConstraints(verticalConstraints + horizontalConstraints)
    }
}