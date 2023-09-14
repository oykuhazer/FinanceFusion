//
//  SignUpFirebaseManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import Firebase
import FirebaseAuth

// Creates a new user account using the provided email and password.
// Calls the completion handler with an optional error parameter upon completion.

class SignUpFirebaseManager {
    static func createUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            completion(error)
        }
    }
}
