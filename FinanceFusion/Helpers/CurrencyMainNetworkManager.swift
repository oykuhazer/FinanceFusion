//
//  CurrencyMainNetworkManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import RxSwift

class MainNetworkManager {
    // Shared instance of the network manager for easy access.
    static let shared = MainNetworkManager()
    
    // Private initializer to enforce singleton pattern.
    private init() {}
    
    // Fetches exchange rates for a given currency using RxSwift's Observable pattern.
    // - Parameter currency: The currency code for which exchange rates are requested.
    // - Returns: An observable sequence of ExchangeRateResponse or an error.
    func fetchExchangeRates(for currency: String) -> Observable<ExchangeRateResponse> {
        let apiUrl = "https://api.frankfurter.app/latest?from=\(currency)"
        
        // Create a URL based on the API endpoint.
        guard let url = URL(string: apiUrl) else {
            return Observable.error(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        // Create an observable sequence to perform the network request.
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    // Notify observers of an error if there's a network error.
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    // Notify observers of an error if no data is received.
                    observer.onError(NSError(domain: "No data received", code: 0, userInfo: nil))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    // Decode the received data into an ExchangeRateResponse object.
                    let exchangeRateResponse = try decoder.decode(ExchangeRateResponse.self, from: data)
                    // Notify observers with the decoded response and complete the sequence.
                    observer.onNext(exchangeRateResponse)
                    observer.onCompleted()
                } catch {
                    // Notify observers of a decoding error.
                    observer.onError(error)
                }
            }
            task.resume()
            
            // Return a disposable to cancel the network request when the sequence is disposed.
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
