//
//  FlightLegView.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit
import AlamofireImage

final class FlightLegView: UIView, NibFileOwnerLoadable {

    private enum Constants {
        static let placeholderImage = UIImage.from(color: .lipstick)
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var timesLabel: UILabel!
    @IBOutlet private weak var placesLabel: UILabel!
    @IBOutlet private weak var segmentsLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    func configure(imageURL: URL?, times: String, places: String, segments: String, duration: String) {
        if let imageURL = imageURL {
            imageView.af_setImage(withURL: imageURL, placeholderImage: Constants.placeholderImage)
        } else {
            imageView.image = nil
        }
        timesLabel.text = times
        placesLabel.text = places
        segmentsLabel.text = segments
        durationLabel.text = duration
    }
}
