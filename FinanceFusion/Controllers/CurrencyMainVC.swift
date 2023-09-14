//
//  CurrencyMainVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//

import UIKit
import RxCocoa
import RxSwift

class CurrencyMainVC: UIViewController {
    
    // Dispose bag for RxSwift
      private let disposeBag = DisposeBag()
      
      // Subject for searching text
      private let searchTextSubject = PublishSubject<String>()
      
      // Views and data properties
      var mainView: CurrencyMainView!
      var selectedCurrency: String = ""
      var currencyPairs: [String] = []
      var exchangeRates: [String: Double] = [:]
      
      // List of currencies
      let currencies: [String] = [
          "USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF", "CNY", "SEK", "NZD",
          "KRW", "SGD", "NOK", "MXN", "INR", "RUB", "BRL", "ZAR", "HKD", "TRY",
          "IDR", "HUF", "PLN", "PHP", "THB"
      ]
      
      override func loadView() {
          mainView = CurrencyMainView(frame: UIScreen.main.bounds)
          view = mainView
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Set delegates for collection view, table view, and search bar
          mainView.collectionView.delegate = self
          mainView.collectionView.dataSource = self
          mainView.tableView.delegate = self
          mainView.tableView.dataSource = self
          mainView.searchBar.delegate = self
          
          // Set the initial selected currency and fetch exchange rates
          if let firstCurrency = currencies.first {
              selectedCurrency = firstCurrency
              fetchExchangeRates(for: selectedCurrency)
          }
          
          // Reload collection view and table view data
          mainView.collectionView.reloadData()
          mainView.tableView.reloadData()
          
          // Set up the navigation bar
          setupNavigationBar()
      }
      
      // Function to set up navigation bar
      func setupNavigationBar() {
          navigationItem.rightBarButtonItem = createBarButtonItem(title: "Converter", action: #selector(openConverter))
          navigationItem.leftBarButtonItem = createBarButtonItem(title: "Portfolio", action: #selector(openPortfolio))
      }
      
      // Function to open the converter view controller
      @objc func openConverter() {
          let converterViewController = ConverterVC()
          navigationController?.pushViewController(converterViewController, animated: true)
      }
      
      // Function to open the portfolio view controller
      @objc func openPortfolio() {
          let portfolioViewController = PortfolioVC()
          navigationController?.pushViewController(portfolioViewController, animated: true)
      }
      
      // Function to create a bar button item
      func createBarButtonItem(title: String, action: Selector) -> UIBarButtonItem {
          let button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
          button.tintColor = .systemGray5
          button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .semibold)], for: .normal)
          return button
      }
      
      // Function to fetch exchange rates for a given currency
      func fetchExchangeRates(for currency: String) {
          MainNetworkManager.shared.fetchExchangeRates(for: currency)
              .observe(on: MainScheduler.instance)
              .subscribe(onNext: { [weak self] exchangeRateResponse in
                  let rates = exchangeRateResponse.rates
                  self?.exchangeRates = rates
                  self?.currencyPairs = Array(rates.keys).sorted()
                  self?.mainView.tableView.reloadData()
              }, onError: { error in
                  print("Error: \(error)")
              })
              .disposed(by: disposeBag)
      }
  }
