//
//  CurrencyMainExtension.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit

// This extension conforms to UICollectionViewDataSource and UICollectionViewDelegate protocols.
extension CurrencyMainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    // Returns the number of items in the collection view section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    // Returns a cell for a given index path in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionCell", for: indexPath)
        
        // Set the background color of the cell.
        cell.backgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)
        
        // Remove any existing subviews from the cell's content view.
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Configure and add a label to display currency information.
        let currency = currencies[indexPath.item]
        let currencyLabel = UILabel()
        currencyLabel.text = currency
        currencyLabel.textColor = .systemGray5
        currencyLabel.textAlignment = .center
        currencyLabel.frame = cell.contentView.bounds
        cell.contentView.addSubview(currencyLabel)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // Handles selection of a collection view cell.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            // Change the text color of the selected currency label to green.
            if let currencyLabel = cell.contentView.subviews.first as? UILabel {
                currencyLabel.textColor = UIColor.green
            }
            
            // Add a green line at the bottom of the selected cell.
            let selectedlineView = UIView()
            selectedlineView.backgroundColor = UIColor.green
            let lineHeight: CGFloat = 2.0
            selectedlineView.frame = CGRect(x: 0, y: cell.frame.size.height - lineHeight, width: cell.frame.size.width, height: lineHeight)
            cell.addSubview(selectedlineView)
            
            // Update the selected currency and reload the table view.
            selectedCurrency = currencies[indexPath.item]
            mainView.tableView.reloadData()
        }
        
        // Deselect other cells and reset their appearance.
        for otherIndexPath in collectionView.indexPathsForVisibleItems {
            if otherIndexPath != indexPath, let otherCell = collectionView.cellForItem(at: otherIndexPath) {
                
                // Reset the text color of other currency labels to systemGray5.
                if let label = otherCell.contentView.subviews.first as? UILabel {
                    label.textColor = .systemGray5
                }
                
                // Remove the green line from other cells.
                for subview in otherCell.subviews {
                    if subview.backgroundColor == UIColor.green {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
        
        // Fetch exchange rates for the selected currency.
        fetchExchangeRates(for: selectedCurrency)
    }
}

// This extension conforms to UITableViewDataSource and UITableViewDelegate protocols.
extension CurrencyMainVC: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    // Returns the number of rows in the table view section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyPairs.count
    }
    
    // Returns a cell for a given index path in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        // Set the background color of the cell.
        cell.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
        
        // Set text color and content for the cell based on currency pair and exchange rate data.
        let currencyPair = currencyPairs[indexPath.row]
        if let rate = exchangeRates[currencyPair] {
            cell.textLabel?.text = "\(selectedCurrency)/\(currencyPair) \(rate)"
        }
        
        // Set text color for the cell's text label.
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    // Handles selection of a table view cell.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrencyPair = currencyPairs[indexPath.row]
        
        // Create a CurrencyDetailVC instance and push it to the navigation stack.
        let detailViewController = CurrencyDetailVC(currencyPair: selectedCurrencyPair, selectedCurrency: selectedCurrency, exchangeRates: [:])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // Returns the height for table view cells.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

// This extension conforms to UISearchBarDelegate protocol.
extension CurrencyMainVC: UISearchBarDelegate {
    
    // Handles the search button click event.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Filter data based on the search text.
            filterData(with: searchText)
        }
    }
    
    // Handles text changes in the search bar.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter data based on the search text.
        filterData(with: searchText)
    }
    
    // Filters currency data based on the search text.
    func filterData(with searchText: String) {
        let filteredData = currencies.filter { $0.lowercased().contains(searchText.lowercased()) }
        currencyPairs = filteredData
        mainView.tableView.reloadData()
    }
}
