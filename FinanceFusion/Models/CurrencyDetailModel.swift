//
//  CurrencyDetailModel.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation

struct ExchangeRate: Codable {
    let rates: [String: [String: Double]]
}
