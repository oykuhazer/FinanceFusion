//
//  AuthenticationView.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class AuthenticationView: UIView {
    
    // DisposeBag is used for managing disposables in RxSwift.
    private let disposeBag = DisposeBag()
    
    // Constants for button dimensions and styling.
    private let buttonHeight: CGFloat = 70
    private let buttonWidth: CGFloat = 300
    private let buttonCornerRadius: CGFloat = 10
    private let buttonBackgroundColor = UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1)
    private let buttonTitleColor = UIColor.white
    
    // Buttons for sign-up and login.
    private let signUpButton = UIButton(type: .custom)
    private let loginButton = UIButton(type: .custom)
    
    // Weak reference to the parent view controller (AuthenticationVC).
    weak var controller: AuthenticationVC?
    
    // Initializer for the AuthenticationView.
    init() {
        super.init(frame: .zero)
        configureButtons()
    }
    
    // Required initializer when using NSCoder, not implemented here.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This method is called when the view's layout changes.
    override func layoutSubviews() {
        super.layoutSubviews()
        // Set the frames of the sign-up and login buttons.
        signUpButton.frame = CGRect(x: bounds.midX - buttonWidth / 2, y: bounds.midY - buttonHeight, width: buttonWidth, height: buttonHeight)
        loginButton.frame = CGRect(x: bounds.midX - buttonWidth / 2, y: bounds.midY + 10, width: buttonWidth, height: buttonHeight)
    }
    
    // Configures the sign-up and login buttons.
    private func configureButtons() {
        addButton(button: signUpButton, title: "Sign Up")
        addButton(button: loginButton, title: "Log In")
    }
    
    // Helper method to set up button properties and add them to the view.
    private func addButton(button: UIButton, title: String) {
        button.backgroundColor = buttonBackgroundColor
        button.layer.cornerRadius = buttonCornerRadius
        button.setTitle(title, for: .normal)
        button.setTitleColor(buttonTitleColor, for: .normal)
        
        // Using RxSwift to handle button tap events.
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                // Call the handleButtonTap method on the parent view controller, if available.
                self?.controller?.handleButtonTap(title)
            })
            .disposed(by: disposeBag)
        
        // Add the button to the view.
        addSubview(button)
    }
}
