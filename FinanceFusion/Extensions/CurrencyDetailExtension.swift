//
//  CurrencyDetailExtension.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit
import DGCharts


// This extension conforms to the UITableViewDataSource and UITableViewDelegate protocols
extension CurrencyDetailVC: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource Methods
    
    // Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }

    // Configures and returns a cell for a given row index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        configureCell(cell, forRowAt: indexPath)
        return cell
    }

    // Configures the cell content for a given row index
    func configureCell(_ cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Set cell background color and text color
        cell.backgroundColor = lightGreenColor
        cell.textLabel?.textColor = UIColor.white

        // Get sorted date keys
        let dateKeys = Array(exchangeRates.keys).sorted(by: >)

        // Check if the index is valid, if not, display an error message
        guard dateKeys.indices.contains(indexPath.row) else {
            cell.textLabel?.text = "Invalid date index"
            return
        }

        let date = dateKeys[indexPath.row]

        // Calculate percentage change and format the text
        if let rateDict = exchangeRates[date], let rate = rateDict[currencyPair] {
            let previousRate: Double
            if dateKeys.indices.contains(indexPath.row + 1) {
                previousRate = exchangeRates[dateKeys[indexPath.row + 1]]?[currencyPair] ?? rate
            } else {
                previousRate = rate
            }

            let percentageChange = ((rate - previousRate) / previousRate) * 100.0
            let changeText = String(format: "%.2f", abs(percentageChange))
            let changeColor: UIColor = percentageChange >= 0 ? .green : .red
            let changeSign = percentageChange >= 0 ? "+" : "-"

            // Create an attributed string for rate and percentage change
            let changeAttributedString = NSMutableAttributedString(string: "(\(changeSign)\(changeText)%)")
            changeAttributedString.addAttribute(.foregroundColor, value: changeColor, range: NSRange(location: 0, length: changeAttributedString.length))

            let rateString = "\(date)                  \(rate)  "
            let attributedString = NSMutableAttributedString(string: rateString)
            attributedString.append(changeAttributedString)

            cell.textLabel?.attributedText = attributedString
        } else {
            cell.textLabel?.text = "Rate not found for date: \(date)"
        }
    }
}

// This extension conforms to the ChartViewDelegate protocol
extension CurrencyDetailVC: ChartViewDelegate {

    // Update the line chart view with data
    func updateLineChartView(with dateKeys: [String]) {
        let chartDataEntries = generateChartDataEntries(dateKeys: dateKeys)
        configureAxis()
        configureDataSet(chartDataEntries: chartDataEntries)
    }

    // Generate chart data entries from date keys and exchange rates
    func generateChartDataEntries(dateKeys: [String]) -> [ChartDataEntry] {
        var chartDataEntries: [ChartDataEntry] = []
        var minRate = Double.greatestFiniteMagnitude
        var maxRate = -Double.greatestFiniteMagnitude

        // Sort date keys
        let sortedDateKeys = dateKeys.sorted(by: { $0 < $1 })

        for (index, date) in sortedDateKeys.enumerated() {
            if let rateDict = exchangeRates[date], let rate = rateDict[currencyPair] {
                let dataEntry = ChartDataEntry(x: Double(index), y: rate)
                chartDataEntries.append(dataEntry)

                minRate = min(minRate, rate)
                maxRate = max(maxRate, rate)
            }
        }

        // Configure x-axis labels
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sortedDateKeys)

        // Configure y-axis range
        lineChartView.leftAxis.axisMinimum = minRate - 1
        lineChartView.leftAxis.axisMaximum = maxRate + 1

        return chartDataEntries
    }

    // Configure chart axis properties
    func configureAxis() {
        lineChartView.leftAxis.labelTextColor = UIColor.systemGray5
        lineChartView.xAxis.labelRotationAngle = -45
        lineChartView.xAxis.labelTextColor = UIColor.systemGray5
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.enabled = true
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.legend.enabled = false
        lineChartView.chartDescription.enabled = false
        lineChartView.drawBordersEnabled = false
    }

    // Configure chart dataset properties
    func configureDataSet(chartDataEntries: [ChartDataEntry]) {
        let dataSet = LineChartDataSet(entries: chartDataEntries, label: "Support and Resistance")
        dataSet.colors = [lightGreenColor]
        dataSet.lineWidth = 1.0
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = lightGreenColor
        dataSet.fillAlpha = 0.2

        let chartData = LineChartData(dataSet: dataSet)

        DispatchQueue.main.async {
            self.lineChartView.data = chartData
            self.lineChartView.notifyDataSetChanged()
        }
    }
}
