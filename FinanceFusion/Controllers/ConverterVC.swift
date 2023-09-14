//
//  ConverterVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//


import UIKit
import RxSwift

class ConverterVC: UIViewController {

    // Array of available currencies.
      let currencies: [String] = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF", "CNY", "SEK", "NZD", "KRW", "SGD", "HKD", "NOK", "TRY", "INR", "RUB", "BRL", "ZAR", "AED"]
      
      // Selected "From Currency" and "To Currency" initial values.
      var selectedFromCurrency: String = "USD"
      var selectedToCurrency: String = "EUR"
      
      // Initial amount to convert.
      var amount: Double = 0
      
      // UI elements.
      var textField: UITextField!
      var resultLabel: UILabel!
      var rateLabel: UILabel!
      var fromCurrencyButton: UIButton!
      var toCurrencyButton: UIButton!
      var reverseButton: UIButton!
      
      // Custom green color.
      let customGreenColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
      
      // DisposeBag for RxSwift subscriptions.
      private let disposeBag = DisposeBag()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
      }
      
      // Function to set up the user interface.
      func setupUI() {
          view.backgroundColor = .systemGray5
          
          // Create a white view in the center of the screen.
          let whiteViewWidth: CGFloat = view.frame.width - 40
          let whiteViewX = (view.frame.width - whiteViewWidth) / 2
          let whiteView = UIView()
          whiteView.backgroundColor = .white
          whiteView.layer.cornerRadius = 10
          whiteView.frame = CGRect(x: whiteViewX, y: 100, width: whiteViewWidth, height: 300)
          view.addSubview(whiteView)
          
          // Create a line view within the white view to separate sections.
          let lineView = UIView()
          lineView.backgroundColor = .systemGray5
          lineView.frame = CGRect(x: 20, y: whiteView.frame.height / 2, width: whiteView.frame.width - 40, height: 1)
          whiteView.addSubview(lineView)
          
          // Labels for "Sold Currency" and "Bought Currency".
          let soldLabel = UILabel()
          soldLabel.text = "Sold Currency"
          soldLabel.textColor = customGreenColor
          soldLabel.frame = CGRect(x: 20, y: 20, width: 120, height: 30)
          whiteView.addSubview(soldLabel)
          
          let boughtLabel = UILabel()
          boughtLabel.text = "Bought Currency"
          boughtLabel.textColor = customGreenColor
          boughtLabel.frame = CGRect(x: 20, y: lineView.frame.origin.y + 40, width: 140, height: 30)
          whiteView.addSubview(boughtLabel)
          
          // Create buttons for selecting "From Currency" and "To Currency".
          fromCurrencyButton = createCurrencyButton(title: selectedFromCurrency)
          fromCurrencyButton.backgroundColor = customGreenColor
          fromCurrencyButton.setTitleColor(.white, for: .normal)
          whiteView.addSubview(fromCurrencyButton)
          
          toCurrencyButton = createCurrencyButton(title: selectedToCurrency)
          toCurrencyButton.backgroundColor = customGreenColor
          toCurrencyButton.setTitleColor(.white, for: .normal)
          whiteView.addSubview(toCurrencyButton)
          
          // Label for displaying the conversion rate.
          rateLabel = UILabel()
          rateLabel.textColor = customGreenColor
          rateLabel.backgroundColor = .systemGray5
          rateLabel.textAlignment = .center
          rateLabel.layer.cornerRadius = 10
          rateLabel.layer.masksToBounds = true
          rateLabel.frame = CGRect(x: 20, y: lineView.frame.origin.y - 15 , width: 200, height: 30)
          whiteView.addSubview(rateLabel)
          
          // Text field for entering the amount to convert.
          textField = UITextField()
          textField.placeholder = "0.00"
          textField.keyboardType = .decimalPad
          textField.layer.borderColor = customGreenColor.cgColor
          textField.layer.borderWidth = 2.0
          textField.frame = CGRect(x: fromCurrencyButton.frame.origin.x + 260, y: 158, width: 100, height: 30)
          textField.textColor = .black
          textField.textAlignment = .center
          textField.backgroundColor = .white
          textField.delegate = self
          view.addSubview(textField)
          
          // Label for displaying the conversion result.
          resultLabel = UILabel()
          resultLabel.text = ""
          resultLabel.textAlignment = .center
          resultLabel.textColor = .black
          resultLabel.backgroundColor = .white
          resultLabel.layer.borderColor = customGreenColor.cgColor
          resultLabel.layer.borderWidth = 2.0
          resultLabel.frame = CGRect(x: toCurrencyButton.frame.origin.x + 250, y: 330, width: 110, height: 30)
          view.addSubview(resultLabel)
          
          // Button for reversing the currency pair.
          reverseButton = UIButton()
          reverseButton.translatesAutoresizingMaskIntoConstraints = false
          reverseButton.backgroundColor = customGreenColor
          reverseButton.layer.cornerRadius = 25
          
          if let reverseImage = UIImage(named: "reverse") {
              let imageView = UIImageView(image: reverseImage)
              imageView.contentMode = .scaleAspectFit
              reverseButton.addSubview(imageView)
              
              imageView.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  imageView.centerXAnchor.constraint(equalTo: reverseButton.centerXAnchor),
                  imageView.centerYAnchor.constraint(equalTo: reverseButton.centerYAnchor),
                  imageView.widthAnchor.constraint(equalTo: reverseButton.widthAnchor, multiplier: 0.6),
                  imageView.heightAnchor.constraint(equalTo: reverseButton.heightAnchor, multiplier: 0.6)
              ])
          }
          
          reverseButton.addTarget(self, action: #selector(reverseCurrencyPair), for: .touchUpInside)
          view.addSubview(reverseButton)
          reverseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
          reverseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          reverseButton.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor).isActive = true
          reverseButton.trailingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 0).isActive = true
          
          // Auto layout constraints for currency buttons.
          NSLayoutConstraint.activate([
              fromCurrencyButton.topAnchor.constraint(equalTo: soldLabel.bottomAnchor, constant: 10),
              fromCurrencyButton.leadingAnchor.constraint(equalTo: soldLabel.leadingAnchor, constant: 0),
              fromCurrencyButton.widthAnchor.constraint(equalToConstant: 80),
              fromCurrencyButton.heightAnchor.constraint(equalToConstant: 30),
              
              toCurrencyButton.topAnchor.constraint(equalTo: boughtLabel.bottomAnchor, constant: 10),
              toCurrencyButton.leadingAnchor.constraint(equalTo: boughtLabel.leadingAnchor, constant: 0),
              toCurrencyButton.widthAnchor.constraint(equalToConstant: 80),
              toCurrencyButton.heightAnchor.constraint(equalToConstant: 30),
          ])
          
     // Add target actions for buttons and update the rate label.
     textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
     reverseButton.addTarget(self, action: #selector(reverseCurrencyPair), for: .touchUpInside)
     fromCurrencyButton.addTarget(self, action: #selector(showFromCurrencyPicker), for: .touchUpInside)
     toCurrencyButton.addTarget(self, action: #selector(showToCurrencyPicker), for: .touchUpInside)
     updateRateLabel()
    }
    
    // MARK: - Helper Function
   
    // This function creates a UIButton with a custom title.
    func createCurrencyButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // Reverses the currency pair between two currencies.
    @objc func reverseCurrencyPair() {
        let temp = selectedFromCurrency
        selectedFromCurrency = selectedToCurrency
        selectedToCurrency = temp

        fromCurrencyButton.setTitle(selectedFromCurrency, for: .normal)
        toCurrencyButton.setTitle(selectedToCurrency, for: .normal)

        fetchExchangeRatesAndConvert()
        updateRateLabel()
    }
    
    // Displays an UIAlertController to show the "From Currency" selection.
    @objc func showFromCurrencyPicker() {
        let alertController = UIAlertController(title: "Select From Currency", message: nil, preferredStyle: .actionSheet)

        let currencySelection = PublishSubject<String>()

        for currency in currencies {
            let action = UIAlertAction(title: currency, style: .default) { (_) in
                currencySelection.onNext(currency)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = fromCurrencyButton
            popoverPresentationController.sourceRect = fromCurrencyButton.bounds
        }

        present(alertController, animated: true, completion: nil)

        currencySelection
            .subscribe(onNext: { [unowned self] currency in
                self.selectedFromCurrency = currency
                self.fromCurrencyButton.setTitle(currency, for: .normal)
                self.fetchExchangeRatesAndConvert()
                self.updateRateLabel()
            })
            .disposed(by: disposeBag)
    }

    // Displays an UIAlertController to show the "To Currency" selection.
    @objc func showToCurrencyPicker() {
        let alertController = UIAlertController(title: "Select to Currency", message: nil, preferredStyle: .actionSheet)

        let currencySelection = PublishSubject<String>()

        for currency in currencies {
            let action = UIAlertAction(title: currency, style: .default) { (_) in
                currencySelection.onNext(currency)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = toCurrencyButton
            popoverPresentationController.sourceRect = toCurrencyButton.bounds
        }

        present(alertController, animated: true, completion: nil)

        currencySelection
            .subscribe(onNext: { [unowned self] currency in
                self.selectedToCurrency = currency
                self.toCurrencyButton.setTitle(currency, for: .normal)
                self.fetchExchangeRatesAndConvert()
                self.updateRateLabel()
            })
            .disposed(by: disposeBag)
    }

    // Fetches exchange rates and performs conversion.
    func fetchExchangeRatesAndConvert() {
        ConverterNetworkManager.shared.getExchangeRate(fromCurrency: selectedFromCurrency, toCurrency: selectedToCurrency) { result in
            switch result {
            case .success(let conversionRate):
                let convertedAmount = self.amount * conversionRate

                DispatchQueue.main.async {
                    let formattedResult = String(format: "%.2f", convertedAmount)
                    self.resultLabel.text = formattedResult
                }

            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }

    // Updates the exchange rate label.
    func updateRateLabel() {
        guard let url = URL(string: "https://api.frankfurter.app/latest?from=\(selectedFromCurrency)&to=\(selectedToCurrency)") else {
            return
        }

        URLSession.shared.rx
            .data(request: URLRequest(url: url))
            .subscribe(onNext: { [unowned self] data in
                do {
                    let exchangeRates = try JSONDecoder().decode(ExchangeRates.self, from: data)
                    let conversionRate = exchangeRates.rates[self.selectedToCurrency] ?? 1.0
                    
                    let formattedRate = String(format: "1 %@ = %.4f %@", self.selectedFromCurrency, 1.0 / conversionRate, self.selectedToCurrency)
                    
                    DispatchQueue.main.async {
                        self.rateLabel.text = formattedRate
                    }
                } catch {
                    print("Error decoding JSON for rate: \(error)")
                }
            }, onError: { error in
                print("Error fetching data: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    }
