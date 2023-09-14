//
//  PortfolioVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//

import UIKit
import RealmSwift


class PortfolioVC: UIViewController {
    
    // A collection of portfolio items retrieved from a data source.
       var portfolioItems: Results<PortfolioItem>!
       
       // Service responsible for managing portfolio data.
       let portfolioService = PortfolioService()
       
       // The view used to display the portfolio content.
       let portfolioView = PortfolioView()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Set the view to the custom portfolio view.
           view = portfolioView
           
           // Set the delegate and data source for the portfolio table view.
           portfolioView.tableView.delegate = self
           portfolioView.tableView.dataSource = self
           
           // Register a default table view cell for the portfolio items.
           portfolioView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PortfolioCell")
           
           // Fetch and load portfolio items when the view loads.
           fetchPortfolioItems()
       }
       
       // Fetches the portfolio items from the data source and updates the table view.
       private func fetchPortfolioItems() {
           portfolioItems = portfolioService.getAllPortfolioItems()
           portfolioView.tableView.reloadData()
       }
   }


