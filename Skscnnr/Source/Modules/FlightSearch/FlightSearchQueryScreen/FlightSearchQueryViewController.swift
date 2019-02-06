//
//  FlightSearchQueryViewController.swift
//  Skscnnr
//
//  Created by Luis Valdés on 03/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import UIKit

final class FlightSearchQueryViewController: UIViewController {
    @IBOutlet private weak var goButton: UIButton!

    var findFlights: (FlightSearchQuery, LocalizationPreferences) -> Void = { _,_  in }

    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 5
    }
    
    @IBAction private func goFindFlights(_ sender: Any) {
        let localizationPreferences = LocalizationPreferences(locale: "en-GB",
                                                              country: "UK",
                                                              currency: "GBP")

        let calendar = Calendar(identifier: .gregorian)
        let mondays = DateComponents(calendar: calendar, weekday: calendar.firstWeekday + 1)
        let now = Date()
        guard let outbound = calendar.nextDate(after: now, matching: mondays, matchingPolicy: .strict) else {
            print("Failed to retrieve next Monday")
            return
        }

        let inbound = outbound.adding(1, component: .day)
        let searchQuery = FlightSearchQuery(origin: .edi, destination: .lhr, outboundDate: outbound, inboundDate: inbound, adults: 1)
        
        findFlights(searchQuery, localizationPreferences)
    }
}
