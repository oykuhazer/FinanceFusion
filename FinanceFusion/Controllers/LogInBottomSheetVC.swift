//
//  LogInBottomSheetVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

class LogInBottomSheetVC: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let logInView = LogInBottomSheetView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view background color
        view.backgroundColor = .white

        // Add logInView as a subview and set up constraints
        logInView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logInView)

        NSLayoutConstraint.activate([
            logInView.topAnchor.constraint(equalTo: view.topAnchor),
            logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Handle continueButton tap event
        logInView.continueButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.continueButtonTapped()
            })
            .disposed(by: disposeBag)

        // Handle closeButton tap event
        logInView.closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.closeButtonTapped()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Button Actions

    private func continueButtonTapped() {
        // Validate email and password input
        guard let email = logInView.emailTextField.text, !email.isEmpty,
              let password = logInView.passwordTextField.text, !password.isEmpty, password.count >= 10 else {
            showErrorMessage(message: "Please enter a valid email address and a password with at least 10 characters.")
            return
        }

        // Sign in with Firebase
        LogInFirebaseManager.signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error as NSError? {
                if error.code == AuthErrorCode.userNotFound.rawValue {
                    self?.showErrorMessage(message: "User not found. Please check your email.")
                } else if error.code == AuthErrorCode.wrongPassword.rawValue {
                    self?.showErrorMessage(message: "Wrong password. Please check your password.")
                } else {
                    self?.showErrorMessage(message: "An error occurred. Please try again later.")
                }
            } else {
                // Navigate to the CurrencyMainVC upon successful login
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "CurrencyMainVC") as! CurrencyMainVC
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    // MARK: - Alert Handling

    private func showErrorMessage(message: String) {
        showAlert(title: "Error", message: message)
    }

    private func showSuccessMessage(message: String) {
        showAlert(title: "Success", message: message)
    }

    private func showAlert(title: String, message: String) {
        // Show an alert with the specified title and message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Close Button Action

    private func closeButtonTapped() {
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
    }
    
}
