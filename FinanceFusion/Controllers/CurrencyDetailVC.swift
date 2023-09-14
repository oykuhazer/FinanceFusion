//
//  CurrencyDetailVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//

import UIKit
import Charts
import DGCharts
import RealmSwift
import RxCocoa
import RxSwift

class CurrencyDetailVC: UIViewController {
    
    // MARK: - Properties
     
     var currencyPair: String
     var selectedCurrency: String
     var exchangeRates: [String: [String: Double]] = [:]
     
     var tableView: UITableView!
     var segmentControl: UISegmentedControl!
     var lineChartView: LineChartView!
     var scrollView: UIScrollView!
     private let disposeBag = DisposeBag()
     
     let darkGreenColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)
     let lightGreenColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
     
     // MARK: - Initialization
     
     init(currencyPair: String, selectedCurrency: String, exchangeRates: [String: [String: Double]]) {
         self.currencyPair = currencyPair
         self.selectedCurrency = selectedCurrency
         self.exchangeRates = exchangeRates
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     // MARK: - View Lifecycle
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
         lineChartView.delegate = self
         let marker = CustomMarkerView()
         marker.chartView = lineChartView
         lineChartView.marker = marker
     }
  
     // MARK: - User Interface Setup
     
     func setupUI() {
         // Set the background color
         view.backgroundColor = darkGreenColor
         
         // Configure navigation bar title color
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
         title = " \(selectedCurrency) / \(currencyPair) Exchange Rates"

         scrollView = UIScrollView(frame: view.bounds)
         scrollView.contentSize = CGSize(width: view.bounds.width, height: 1200)
         view.addSubview(scrollView)

         let padding: CGFloat = 30.0
         let segmentWidth = view.bounds.width - 2 * padding

         segmentControl = UISegmentedControl(items: ["1 Y", "6 M", "3 M", "1 M", "1 W"])
         segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightGreenColor], for: .normal)
         segmentControl.layer.borderColor = UIColor.white.cgColor
         segmentControl.layer.borderWidth = 1.0
         segmentControl.layer.cornerRadius = 5.0
         segmentControl.clipsToBounds = true
         segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
         segmentControl.frame = CGRect(x: padding, y: 150, width: segmentWidth, height: 44)
         view.addSubview(segmentControl)

         let displayPortfolioButton = UIButton(type: .system)
         displayPortfolioButton.setTitle("Display Portfolio", for: .normal)
         displayPortfolioButton.setTitleColor(lightGreenColor, for: .normal)
         displayPortfolioButton.backgroundColor = UIColor.white
         displayPortfolioButton.layer.borderColor = UIColor.white.cgColor
         displayPortfolioButton.layer.borderWidth = 1.0
         displayPortfolioButton.layer.cornerRadius = 5.0
         displayPortfolioButton.clipsToBounds = true
         displayPortfolioButton.frame = CGRect(x: padding, y: 45, width: segmentWidth, height: 44)
         displayPortfolioButton.addTarget(self, action: #selector(displayPortfolioButtonTapped), for: .touchUpInside)
         view.addSubview(displayPortfolioButton)

         let spacingBetweenChartAndTable: CGFloat = 150.0
         let tableViewPadding: CGFloat = 0.0
         let tableViewBottomPadding: CGFloat = 60.0

         tableView = UITableView(frame: CGRect(x: tableViewPadding, y: 600 + spacingBetweenChartAndTable, width: view.bounds.width - 2 * tableViewPadding, height: view.bounds.height - 220 - tableViewBottomPadding - spacingBetweenChartAndTable), style: .plain)
         tableView.backgroundColor = view.backgroundColor
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
         view.addSubview(tableView)

         let headerLabel = UILabel()
         headerLabel.text = "Value the Specified Date and Change Rate Compared to the Previous Day"
         headerLabel.font = UIFont.boldSystemFont(ofSize: 14)
         headerLabel.textColor = UIColor.systemGray5
         headerLabel.textAlignment = .center
         headerLabel.numberOfLines = 2
         headerLabel.frame = CGRect(x: padding, y: 680, width: segmentWidth, height: 44)
         view.addSubview(headerLabel)

         let chartWidth: CGFloat = view.frame.width - 2 * tableViewPadding
         lineChartView = LineChartView()
         lineChartView.frame = CGRect(x: tableViewPadding, y: 250, width: chartWidth, height: 350)
         lineChartView.noDataText = "No Data"
         lineChartView.backgroundColor = UIColor.clear
         view.addSubview(lineChartView)

         fetchExchangeRatesForCurrencyPair(for: "1 Year")

         scrollView.addSubview(tableView)
         scrollView.addSubview(lineChartView)
         scrollView.addSubview(segmentControl)
         scrollView.addSubview(displayPortfolioButton)
         scrollView.addSubview(headerLabel)
     }
  
     // MARK: - Button Actions
     
     @objc func displayPortfolioButtonTapped() {
         let currencyPair = "\(currencyPair)"
         let selectedCurrency = "\(selectedCurrency)"

         let realm = try! Realm()
         
         let portfolioItem = PortfolioItem()
         portfolioItem.currencyPair = currencyPair
         portfolioItem.selectedCurrency = selectedCurrency
         try! realm.write {
             realm.add(portfolioItem)
         }
     }
     
     // MARK: - Scroll View Configuration
     
     func configureScrollView() {
         scrollView.isScrollEnabled = true
         scrollView.showsVerticalScrollIndicator = true
     }
     
     // MARK: - Segment Control Value Changed
     
     @objc func segmentValueChanged(_ sender: UISegmentedControl) {
         let selectedIndex = sender.selectedSegmentIndex

         var duration: String = ""

         switch selectedIndex {
         case 0:
             duration = "1 Year"
         case 1:
             duration = "6 Months"
         case 2:
             duration = "3 Months"
         case 3:
             duration = "1 Month"
         case 4:
             duration = "1 Week"
         default:
             break
         }
         fetchExchangeRatesForCurrencyPair(for: duration)
     }

     // MARK: - Fetch Exchange Rates
     
     func fetchExchangeRatesForCurrencyPair(for duration: String) {
         CurrencyDetailNetworkManager.shared.fetchExchangeRates(for: duration, selectedCurrency: selectedCurrency, currencyPair: currencyPair)
             .subscribe(onNext: { [weak self] exchangeRates in
                 guard let self = self else { return }
                 self.exchangeRates = exchangeRates
                 self.updateLineChartView(with: Array(exchangeRates.keys))
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             }, onError: { error in
                 print("Error fetching exchange rates: \(error)")
             })
             .disposed(by: disposeBag)
     }
 }
