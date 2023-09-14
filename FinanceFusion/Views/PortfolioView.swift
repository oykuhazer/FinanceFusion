//
//  PortfolioView.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit

class PortfolioView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Initializer
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           // Set the background color for the main view
           self.backgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)
           
           // Set the background color for the table view
           tableView.backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.1, alpha: 1.0)
           
           // Add the table view as a subview
           addSubview(tableView)
           
           // Set up Auto Layout constraints for the table view
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: topAnchor),
               tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
           ])
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
   }
