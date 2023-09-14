//
//  SignUpBottomSheetView.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit

class SignUpBottomSheetView: UIView {

    //MARK: - UI Components
    
    // Label to display the title of the application.
      let titleLabel: UILabel = {
          let label = UILabel()
          label.text = "Finance Fusion Application"
          label.font = UIFont.systemFont(ofSize: 16)
          label.textAlignment = .center
          return label
      }()

      // Label to display a welcome message.
      let welcomeLabel: UILabel = {
          let label = UILabel()
          label.text = "Welcome"
          label.font = UIFont(name: "AvenirNext-Medium", size: 20)
          label.textAlignment = .center
          return label
      }()

      // Text field for entering the email address.
      let emailTextField: UITextField = {
          let textField = UITextField()
          textField.backgroundColor = UIColor.white
          textField.layer.cornerRadius = 25
          textField.layer.borderWidth = 1
          textField.layer.borderColor = UIColor.gray.cgColor
          textField.placeholder = "Email address"
          textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
          textField.leftViewMode = .always
          return textField
      }()

      // Text field for entering the password (secure text entry).
      let passwordTextField: UITextField = {
          let textField = UITextField()
          textField.backgroundColor = UIColor.white
          textField.layer.cornerRadius = 25
          textField.layer.borderWidth = 1
          textField.layer.borderColor = UIColor.gray.cgColor
          textField.placeholder = "Password"
          textField.isSecureTextEntry = true
          textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
          textField.leftViewMode = .always
          return textField
      }()

      // Button for continuing the sign-up process.
      let continueButton: UIButton = {
          let button = UIButton(type: .custom)
          button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
          button.layer.cornerRadius = 30
          button.setTitle("Continue", for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
          button.setTitleColor(UIColor.white, for: .normal)
          return button
      }()

      // Button for closing the sign-up view.
      let closeButton: UIButton = {
          let button = UIButton(type: .custom)
          let buttonSize: CGFloat = 50
          button.setImage(UIImage(systemName: "xmark"), for: .normal)
          button.tintColor = UIColor.darkGray
          return button
      }()
     
    // MARK: - Initializers
    
      override init(frame: CGRect) {
          super.init(frame: frame)
          setupViews()
      }

      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          setupViews()
      }

    // MARK: - UI Setup Function
      // Set up the layout and constraints for subviews.
      private func setupViews() {

          // Add the title label.
          addSubview(titleLabel)
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
              titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
          ])

          // Add the welcome label.
          addSubview(welcomeLabel)
          welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              welcomeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
              welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
          ])

          // Add the email text field.
          addSubview(emailTextField)
          emailTextField.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              emailTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
              emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
              emailTextField.heightAnchor.constraint(equalToConstant: 50),
          ])

          // Add the password text field.
          addSubview(passwordTextField)
          passwordTextField.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
              passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
              passwordTextField.heightAnchor.constraint(equalToConstant: 50),
          ])

          // Add the continue button.
          addSubview(continueButton)
          continueButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
              continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
              continueButton.heightAnchor.constraint(equalToConstant: 60),
          ])

          // Add the close button.
          addSubview(closeButton)
          closeButton.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              closeButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 140),
              closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
          ])
      }
  }
