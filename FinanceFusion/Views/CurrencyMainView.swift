//
//  CurrencyMainView.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit


class CurrencyMainView: UIView, UISearchBarDelegate, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var topView: UIView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           
           // Background color for the main view
           backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.1, alpha: 1.0)
           
           // Setup the top view with a title
           setupTopView()
           
           // Setup the collection view for currency data
           setupCollectionView()
           
           // Setup the table view for currency details
           setupTableView()
           
           // Setup the search bar for filtering data
           setupSearchBar()
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       // Function to set up the top view with the title
       private func setupTopView() {
           topView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 100))
           topView.backgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)
           addSubview(topView)
           
           // Label displaying the title
           titleLabel = UILabel()
           titleLabel.text = "FinanceFusion"
           titleLabel.font = UIFont(name: "Gill Sans", size: 25)
           titleLabel.textColor = .white
           titleLabel.textAlignment = .center
           titleLabel.frame = CGRect(x: 0, y: 60, width: bounds.width, height: 40)
           topView.addSubview(titleLabel)
       }
       
       // Function to set up the collection view for currency data
       private func setupCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumInteritemSpacing = 20.0
           
           collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: bounds.width, height: 50), collectionViewLayout: layout)
           collectionView.backgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CurrencyCollectionCell")
           
           addSubview(collectionView)
           
           collectionView.delegate = self
       }
       
       // Function to set up the table view for currency details
       private func setupTableView() {
           tableView = UITableView(frame: CGRect(x: 0, y: 240, width: bounds.width, height: bounds.height - 260 - 60))
           tableView.backgroundColor = backgroundColor
           tableView.separatorColor = backgroundColor
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CurrencyCell")
           
           addSubview(tableView)
       }
       
       // Function to set up the search bar for filtering data
       private func setupSearchBar() {
           searchBar = UISearchBar(frame: CGRect(x: 0, y: 160, width: bounds.width, height: 50))
           searchBar.backgroundImage = UIImage()
           searchBar.backgroundColor = UIColor.clear
           searchBar.layer.shadowColor = UIColor.black.cgColor
           searchBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
           searchBar.layer.shadowRadius = 2.0
           searchBar.layer.shadowOpacity = 0.3
           searchBar.layer.masksToBounds = false
           searchBar.delegate = self
           
           if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
               textFieldInsideSearchBar.textColor = .systemGray4
               textFieldInsideSearchBar.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
               textFieldInsideSearchBar.layer.cornerRadius = 10
           }
           
           searchBar.placeholder = "Searched Data"
           
           addSubview(searchBar)
       }
   }
