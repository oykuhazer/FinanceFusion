//
//  PortfolioModel.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import RealmSwift

class PortfolioItem: Object {
    @Persisted var selectedCurrency = ""
    @Persisted var currencyPair = ""
}
