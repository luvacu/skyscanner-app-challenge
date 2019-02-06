//
//  FlightSearchAPIPricingResponse.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation

struct FlightSearchAPIResponse: Codable {
    let sessionKey: String
    let query: QueryResponse
    let status: StatusResponse
    let itineraries: [ItineraryResponse]
    let legs: [LegResponse]
    let segments: [SegmentResponse]
    let carriers: [CarrierResponse]
    let agents: [AgentResponse]
    let places: [PlaceResponse]
    let currencies: [CurrencyResponse]

    enum CodingKeys: String, CodingKey {
        case sessionKey = "SessionKey"
        case query = "Query"
        case status = "Status"
        case itineraries = "Itineraries"
        case legs = "Legs"
        case segments = "Segments"
        case carriers = "Carriers"
        case agents = "Agents"
        case places = "Places"
        case currencies = "Currencies"
    }
}

enum StatusResponse: String, Codable {
    case updatesComplete = "UpdatesComplete"
    case updatesPending = "UpdatesPending"
}

struct AgentResponse: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let status: String
    let optimisedForMobile: Bool
    let bookingNumber: String?
    let type: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageURL = "ImageUrl"
        case status = "Status"
        case optimisedForMobile = "OptimisedForMobile"
        case bookingNumber = "BookingNumber"
        case type = "Type"
    }
}

struct CarrierResponse: Codable {
    let id: Int
    let code, name: String
    let imageURL: String
    let displayCode: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case code = "Code"
        case name = "Name"
        case imageURL = "ImageUrl"
        case displayCode = "DisplayCode"
    }
}

struct CurrencyResponse: Codable {
    let code, symbol, thousandsSeparator, decimalSeparator: String
    let symbolOnLeft, spaceBetweenAmountAndSymbol: Bool
    let roundingCoefficient, decimalDigits: Int

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case symbol = "Symbol"
        case thousandsSeparator = "ThousandsSeparator"
        case decimalSeparator = "DecimalSeparator"
        case symbolOnLeft = "SymbolOnLeft"
        case spaceBetweenAmountAndSymbol = "SpaceBetweenAmountAndSymbol"
        case roundingCoefficient = "RoundingCoefficient"
        case decimalDigits = "DecimalDigits"
    }
}

struct ItineraryResponse: Codable {
    let outboundLegID: String
    let inboundLegID: String?
    let pricingOptions: [PricingOptionResponse]
    let bookingDetailsLink: BookingDetailsLinkResponse

    enum CodingKeys: String, CodingKey {
        case outboundLegID = "OutboundLegId"
        case inboundLegID = "InboundLegId"
        case pricingOptions = "PricingOptions"
        case bookingDetailsLink = "BookingDetailsLink"
    }
}

struct BookingDetailsLinkResponse: Codable {
    let uri, body, method: String

    enum CodingKeys: String, CodingKey {
        case uri = "Uri"
        case body = "Body"
        case method = "Method"
    }
}

struct PricingOptionResponse: Codable {
    let agents: [Int]
    let quoteAgeInMinutes: Int
    let price: Double
    let deeplinkURL: String

    enum CodingKeys: String, CodingKey {
        case agents = "Agents"
        case quoteAgeInMinutes = "QuoteAgeInMinutes"
        case price = "Price"
        case deeplinkURL = "DeeplinkUrl"
    }
}

struct LegResponse: Codable {
    let id: String
    let segmentIDS: [Int]
    let originStation, destinationStation: Int
    let departure, arrival: Date
    let duration: Int
    let journeyMode: String
    let stops, carriers, operatingCarriers: [Int]
    let directionality: String
    let flightNumbers: [FlightNumberResponse]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case segmentIDS = "SegmentIds"
        case originStation = "OriginStation"
        case destinationStation = "DestinationStation"
        case departure = "Departure"
        case arrival = "Arrival"
        case duration = "Duration"
        case journeyMode = "JourneyMode"
        case stops = "Stops"
        case carriers = "Carriers"
        case operatingCarriers = "OperatingCarriers"
        case directionality = "Directionality"
        case flightNumbers = "FlightNumbers"
    }
}

struct FlightNumberResponse: Codable {
    let flightNumber: String
    let carrierID: Int

    enum CodingKeys: String, CodingKey {
        case flightNumber = "FlightNumber"
        case carrierID = "CarrierId"
    }
}

struct PlaceResponse: Codable {
    let id: Int
    let parentID: Int?
    let code, type, name: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case parentID = "ParentId"
        case code = "Code"
        case type = "Type"
        case name = "Name"
    }
}

struct QueryResponse: Codable {
    let country, currency, locale: String
    let adults, children, infants: Int
    let originPlace, destinationPlace, outboundDate: String
    let inboundDate: String?
    let locationSchema, cabinClass: String
    let groupPricing: Bool

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case currency = "Currency"
        case locale = "Locale"
        case adults = "Adults"
        case children = "Children"
        case infants = "Infants"
        case originPlace = "OriginPlace"
        case destinationPlace = "DestinationPlace"
        case outboundDate = "OutboundDate"
        case inboundDate = "InboundDate"
        case locationSchema = "LocationSchema"
        case cabinClass = "CabinClass"
        case groupPricing = "GroupPricing"
    }
}

struct SegmentResponse: Codable {
    let id, originStation, destinationStation: Int
    let departureDateTime, arrivalDateTime: Date
    let carrier, operatingCarrier, duration: Int
    let flightNumber, journeyMode, directionality: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case originStation = "OriginStation"
        case destinationStation = "DestinationStation"
        case departureDateTime = "DepartureDateTime"
        case arrivalDateTime = "ArrivalDateTime"
        case carrier = "Carrier"
        case operatingCarrier = "OperatingCarrier"
        case duration = "Duration"
        case flightNumber = "FlightNumber"
        case journeyMode = "JourneyMode"
        case directionality = "Directionality"
    }
}
