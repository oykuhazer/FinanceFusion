//
//  ConverterExtension.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit

// This extension conforms to the UITextFieldDelegate protocol
extension ConverterVC: UITextFieldDelegate {
    
    // This function is called when the text in the text field changes
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Clear the result label
        resultLabel.text = ""
        
        // Check if the entered text can be converted to a Double
        if var text = textField.text, let enteredAmount = Double(text) {
            
            // Limit the text to 7 characters
            if text.count > 7 {
                text = String(text.prefix(7))
                textField.text = text
            }
            
            // Center-align the text in the text field
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributes: [NSAttributedString.Key : Any] = [
                .paragraphStyle: paragraphStyle
            ]
            textField.attributedText = NSAttributedString(string: text, attributes: attributes)
            
            // Set the 'amount' variable to the entered amount
            amount = enteredAmount
            
            // Fetch exchange rates and perform the conversion
            fetchExchangeRatesAndConvert()
        }
    }
}


