//
//  FlightSearchAPIClient.swift
//  Skscnnr
//
//  Created by Luis Valdés on 01/02/2019.
//  Copyright © 2019 Luis Valdés. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

enum FlightSearchAPIClientError: Error {
    case unexpectedResponse
}

struct FlightSearchAPIClient {

    private enum Defaults {
        static let baseURL = "http://partners.api.skyscanner.net/apiservices"
        static let apiKey = "YourAPIKey"
        static let pollingInterval: TimeInterval = 1.0
    }

    private let baseURL: String
    private let apiKey: String
    private let sessionManager: SessionManager

    init(baseURL: String = Defaults.baseURL,
         apiKey: String = Defaults.apiKey,
         urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.sessionManager = SessionManager(configuration: urlSessionConfiguration)
    }

    func fetchLivePricing(query: FlightSearchAPIQuery) -> Observable<FlightSearchAPIResponse> {
        return createLivePricingSession(query: query)
            .asObservable()
            .flatMap { sessionURL in
                return self.pollLivePricingSession(sessionURL: sessionURL)
                    .recursiveConcat(while: { $0.status == .updatesPending }, delaySubscription: Defaults.pollingInterval)
            }
    }

    private func createLivePricingSession(query: FlightSearchAPIQuery) -> Single<String> {
        return Single.create { emitter -> Disposable in
            let request = FlightSearchAPIRequests.createlivePricingSession(baseURL: self.baseURL, apiKey: self.apiKey, query: query)
            let dataRequest = self.sessionManager.request(request)
                .validate(statusCode: 200..<300)
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success:
                        guard let sessionURL = response.response?.allHeaderFields["Location"] as? String else {
                            emitter(.error(FlightSearchAPIClientError.unexpectedResponse))
                            return
                        }
                        emitter(.success(sessionURL))

                    case .failure(let error):
                        emitter(.error(error))
                    }
                })

            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }

    private func pollLivePricingSession(sessionURL: String) -> Single<FlightSearchAPIResponse> {
        return Single.create { emitter -> Disposable in
            let request = FlightSearchAPIRequests.pollLivePricingSession(sessionURL: sessionURL, apiKey: self.apiKey)
            let dataRequest = self.sessionManager.request(request)
                .validate(statusCode: 200..<300)
                .responseFlightSearchAPIResponse(completionHandler: { response in
                    switch response.result {
                    case .success(let pricingResponse):
                        emitter(.success(pricingResponse))
                    case .failure(let error):
                        emitter(.error(error))
                    }
                })

            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}
