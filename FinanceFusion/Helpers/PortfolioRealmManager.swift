//
//  PortfolioRealmManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit
import RealmSwift

// Realm Manager for Portfolio Data
class PortfolioService {
    // A reference to the Realm database.
    private let realm = try! Realm()
    
    // Retrieves all portfolio items stored in the Realm database.
    // - Returns: A collection of PortfolioItem objects.
    func getAllPortfolioItems() -> Results<PortfolioItem> {
        return realm.objects(PortfolioItem.self)
    }
    
    // Adds a new portfolio item to the database.
    // - Parameters:
    //   - selectedCurrency: The selected currency for the portfolio item.
    //   - currencyPair: The currency pair associated with the portfolio item.
    func addPortfolioItem(selectedCurrency: String, currencyPair: String) {
        let newItem = PortfolioItem()
        newItem.selectedCurrency = selectedCurrency
        newItem.currencyPair = currencyPair
        
        try! realm.write {
            realm.add(newItem)
        }
    }
    
    // Deletes a portfolio item from the database.
    // - Parameter item: The PortfolioItem object to be deleted.
    func deletePortfolioItem(_ item: PortfolioItem) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
