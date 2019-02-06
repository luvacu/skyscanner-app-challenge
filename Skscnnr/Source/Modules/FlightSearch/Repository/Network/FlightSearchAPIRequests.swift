//
//  FlightSearchAPIRequests.swift
//  Skscnnr
//
//  Created by Luis Valdés on 02/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import Alamofire

struct FlightSearchAPIRequests {
    private let baseURL: String
    private let path: String
    private let method: HTTPMethod
    private let headers: HTTPHeaders?
    private let parameters: Parameters?

    static func createlivePricingSession(baseURL: String, apiKey: String, query: FlightSearchAPIQuery) -> FlightSearchAPIRequests {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        return FlightSearchAPIRequests(baseURL: baseURL,
                                       path: "/pricing/v1.0",
                                       method: .post,
                                       headers: headers,
                                       parameters: (query.asParameters() ?? [:]) + ["apiKey": apiKey])
    }

    static func pollLivePricingSession(sessionURL: String, apiKey: String) -> FlightSearchAPIRequests {
        let headers = [
            "Accept": "application/json"
        ]
        return FlightSearchAPIRequests(baseURL: sessionURL,
                                       path: "",
                                       method: .get,
                                       headers: headers,
                                       parameters: ["sortType": "price",
                                                    "sortOrder": "asc",
                                                    "apiKey": apiKey])
    }
}

extension FlightSearchAPIRequests: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method, headers: headers)
        if let parameters = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
