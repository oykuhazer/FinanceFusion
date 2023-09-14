//
//  ConverterNetworkManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import RxSwift

class ConverterNetworkManager {
    // Shared instance of the network manager for easy access.
    static let shared = ConverterNetworkManager()

    // The base URL for the API.
    private let baseURL = "https://api.frankfurter.app"

    // The session responsible for handling network requests.
    private let session = URLSession.shared

    // A dispose bag to manage disposables.
    private let disposeBag = DisposeBag()

    // Private initializer to enforce singleton pattern.
    private init() {}

    // Fetches the exchange rate from one currency to another.
    // - Parameters:
    //   - fromCurrency: The currency to convert from.
    //   - toCurrency: The currency to convert to.
    //   - completion: A completion handler with a result containing the conversion rate or an error.
    func getExchangeRate(fromCurrency: String, toCurrency: String, completion: @escaping (Result<Double, Error>) -> Void) {
        // Create a URL based on the provided currencies.
        guard let url = URL(string: "\(baseURL)/latest?from=\(fromCurrency)&to=\(toCurrency)") else {
            // Notify the completion handler of an invalid URL error.
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Use RxSwift to perform a network request and handle the response.
        session.rx
            .data(request: URLRequest(url: url))
            .subscribe(onNext: { data in
                do {
                    // Decode the received data into ExchangeRates model.
                    let exchangeRates = try JSONDecoder().decode(ExchangeRates.self, from: data)
                    // Extract the conversion rate for the specified currency.
                    let conversionRate = exchangeRates.rates[toCurrency] ?? 1.0
                    // Notify the completion handler with the success result.
                    completion(.success(conversionRate))
                } catch {
                    // Notify the completion handler of a decoding error.
                    completion(.failure(error))
                }
            }, onError: { error in
                // Notify the completion handler of a network or other error.
                completion(.failure(error))
            })
            .disposed(by: disposeBag)
    }
}
