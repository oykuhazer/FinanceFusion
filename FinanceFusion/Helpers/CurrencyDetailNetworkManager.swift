//
//  CurrencyDetailNetworkManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import RxSwift

class CurrencyDetailNetworkManager {
    // Shared instance of the network manager for easy access.
    static let shared = CurrencyDetailNetworkManager()
    
    // Private initializer to enforce singleton pattern.
    private init() {}
    
    // Fetches historical exchange rates for a selected duration, currency, and currency pair.
    // - Parameters:
    //   - duration: The selected duration for historical data (e.g., "1 Year", "6 Months").
    //   - selectedCurrency: The base currency for the historical rates.
    //   - currencyPair: The target currency pair for exchange rates.
    // - Returns: An observable sequence of historical exchange rate data.
    func fetchExchangeRates(for duration: String, selectedCurrency: String, currencyPair: String) -> Observable<[String: [String: Double]]> {
        return Observable.create { observer in
            let currentDate = Date()
            var startDate: Date
            let calendar = Calendar.current

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            // Determine the start date based on the selected duration.
            switch duration {
            case "1 Year":
                startDate = calendar.date(byAdding: .year, value: -1, to: currentDate)!
            case "6 Months":
                startDate = calendar.date(byAdding: .month, value: -6, to: currentDate)!
            case "3 Months":
                startDate = calendar.date(byAdding: .month, value: -3, to: currentDate)!
            case "1 Month":
                startDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
            case "1 Week":
                startDate = calendar.date(byAdding: .day, value: -7, to: currentDate)!
            default:
                startDate = calendar.date(byAdding: .year, value: -1, to: currentDate)!
            }

            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: currentDate)

            let apiUrl = "https://api.frankfurter.app/\(startDateString)..\(endDateString)?from=\(selectedCurrency)&to=\(currencyPair)"

            if let url = URL(string: apiUrl) {
                let session = URLSession(configuration: .default)
                var task: URLSessionDataTask?

                task = session.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        // Notify observers of an error if there's a network error.
                        observer.onError(error)
                        return
                    }

                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            // Decode the received data into an ExchangeRate object.
                            let exchangeRateData = try decoder.decode(ExchangeRate.self, from: safeData)

                            let rates = exchangeRateData.rates
                            var sortedExchangeRates: [String: [String: Double]] = [:]

                            // Sort exchange rates by date and format them.
                            for date in rates.keys.sorted(by: { dateFormatter.date(from: $0)! > dateFormatter.date(from: $1)! }) {
                                if let rateDict = rates[date], let rate = rateDict[currencyPair] {
                                    sortedExchangeRates[date] = [currencyPair: rate]
                                }
                            }

                            // Notify observers with the sorted exchange rate data and complete the sequence.
                            observer.onNext(sortedExchangeRates)
                            observer.onCompleted()
                        } catch {
                            // Notify observers of a decoding error.
                            observer.onError(error)
                        }
                    }
                }

                task?.resume()
                
                // Return a disposable to cancel the network request when the sequence is disposed.
                return Disposables.create {
                    task?.cancel()
                }
            }

            // Return an empty disposable if the URL is invalid.
            return Disposables.create()
        }
    }
}
