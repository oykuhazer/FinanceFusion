//
//  bottomSheetVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 4.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift


class SignUpBottomSheetVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let signUpView = SignUpBottomSheetView()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view background color
        view.backgroundColor = .white

        // Add signUpView as a subview and set up constraints
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpView)

        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Handle continueButton tap event
        signUpView.continueButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.continueButtonTapped()
            })
            .disposed(by: disposeBag)

        // Handle closeButton tap event
        signUpView.closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.closeButtonTapped()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Button Actions
    
    private func continueButtonTapped() {
        // Validate email and password input
        guard let email = signUpView.emailTextField.text, !email.isEmpty,
              let password = signUpView.passwordTextField.text, !password.isEmpty, password.count >= 10 else {
            showErrorMessage(message: "Please enter a valid email address and a password with at least 10 characters.")
            return
        }

        if !isValidEmail(email) {
            showErrorMessage(message: "Please enter a valid email address.")
            return
        }

        // Create user with Firebase
        SignUpFirebaseManager.createUser(email: email, password: password) { [weak self] error in
            if let error = error {
                self?.showErrorMessage(message: error.localizedDescription)
            } else {
                self?.showSuccessMessage()
            }
        }
    }

    private func showErrorMessage(message: String) {
        // Show an error message alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func showSuccessMessage() {
        // Show a success message alert
        let alert = UIAlertController(title: "Success", message: "Registration successful!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Validate email format using regular expression
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    private func closeButtonTapped() {
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
    }
}
