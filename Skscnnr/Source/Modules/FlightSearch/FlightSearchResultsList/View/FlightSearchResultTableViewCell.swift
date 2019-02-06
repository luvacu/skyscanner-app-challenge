//
//  FlightSearchResultTableViewCell.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class FlightSearchResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var outboundFlightLegView: FlightLegView!
    @IBOutlet private weak var inboundFlightLegView: FlightLegView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var flagsLabel: UILabel!

    func configure(with viewModel: FlightSearchResultViewModel) {
        configureFlightLegView(outboundFlightLegView, with: viewModel.outboundLeg)

        if let inboundLeg = viewModel.inboundLeg {
            configureFlightLegView(inboundFlightLegView, with: inboundLeg)
        } else {
            inboundFlightLegView.isHidden = true
        }

        priceLabel.text = viewModel.price
        flagsLabel.text = viewModel.flags
    }

    private func configureFlightLegView(_ view: FlightLegView, with viewModel: FlightLegViewModel) {
        view.configure(imageURL: viewModel.carrierImageURL,
                       times: viewModel.times,
                       places: viewModel.places,
                       segments: viewModel.segments,
                       duration: viewModel.duration)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        inboundFlightLegView.isHidden = false
    }
}
