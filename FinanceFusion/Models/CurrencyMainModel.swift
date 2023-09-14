//
//  CurrencyMainModel.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}
