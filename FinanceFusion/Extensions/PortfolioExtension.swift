//
//  PortfolioExtension.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit

// Conform to UITableViewDataSource and UITableViewDelegate protocols
extension PortfolioVC: UITableViewDataSource, UITableViewDelegate {
    
    // Define the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioItems.count
    }
    
    // Define the height for each row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    // Configure and return a cell for a specific row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath)
        
        // Get the portfolio item for the current row
        let portfolioItem = portfolioItems[indexPath.row]
        
        // Set the cell's text label to display currency information
        cell.textLabel?.text = "\(portfolioItem.selectedCurrency) / \(portfolioItem.currencyPair)"
        
        // Customize the text color and background color of the cell
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
        
        return cell
    }
    
    // Specify whether a row can be edited (for example, for deletion)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Handle the deletion of a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the portfolio item to be deleted
            let portfolioItemToDelete = portfolioItems[indexPath.row]
            
            // Delete the portfolio item from the data source (portfolioService)
            portfolioService.deletePortfolioItem(portfolioItemToDelete)
            
            // Begin updates for the table view
            tableView.beginUpdates()
            
            // Delete the row with a fade animation
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // End updates for the table view
            tableView.endUpdates()
        }
    }
    
    // Handle the selection of a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the selected row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the portfolio item for the selected row
        let portfolioItem = portfolioItems[indexPath.row]
        
        // Create a CurrencyDetailVC with relevant data and push it onto the navigation stack
        let currencyDetailVC = CurrencyDetailVC(currencyPair: portfolioItem.currencyPair, selectedCurrency: portfolioItem.selectedCurrency, exchangeRates: [:])
        navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}
