//
//  LogInFirebaseManager.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 13.09.2023.
//

import Foundation
import Firebase
import FirebaseAuth

// Signs in a user with the provided email and password.
// Calls the completion handler with an optional AuthDataResult and an optional error upon completion.

class LogInFirebaseManager {
    static func signIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            completion(authResult, error)
        }
    }
}
