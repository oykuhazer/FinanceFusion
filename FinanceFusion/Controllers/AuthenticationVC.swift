//
//  MainVC.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 8.09.2023.
//

import UIKit
import RxSwift
import RxCocoa

class AuthenticationVC: UIViewController {
    private var bottomSheetVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an instance of AuthenticationView
        let authenticationView = AuthenticationView()
        
        // Set the controller property of authenticationView to self
        authenticationView.controller = self
        
        // Add authenticationView as a subview to the view of this view controller
        view.addSubview(authenticationView)
        
        // Set the background color of the view
        view.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.2, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Adjust the frame of authenticationView to match the bounds of the view
        if let authenticationView = view.subviews.first as? AuthenticationView {
            authenticationView.frame = view.bounds
        }
    }
    
    // Handle button tap actions
    func handleButtonTap(_ title: String) {
        switch title {
        case "Sign Up":
            // Configure and present the Sign Up bottom sheet
            configureSheet(with: SignUpBottomSheetVC())
        case "Log In":
            // Configure and present the Log In bottom sheet
            configureSheet(with: LogInBottomSheetVC())
        default:
            break
        }
    }
    
    // Configure and present the bottom sheet
    private func configureSheet(with viewController: UIViewController) {
        self.bottomSheetVC = viewController
        
        // Create a navigation controller with the provided view controller
        let navVC = UINavigationController(rootViewController: viewController)
        
        // Enable modal in presentation for the navigation controller
        navVC.isModalInPresentation = true

        // Configure the presentation controller for the bottom sheet
        if let sheet = navVC.presentationController as? UISheetPresentationController {
            sheet.preferredCornerRadius = 30
            sheet.detents = [.custom { _ in 0.9 * UIScreen.main.bounds.height }, .large()]
            sheet.largestUndimmedDetentIdentifier = .large
        }

        // Present the navigation controller with the bottom sheet
        present(navVC, animated: true)
    }
}
