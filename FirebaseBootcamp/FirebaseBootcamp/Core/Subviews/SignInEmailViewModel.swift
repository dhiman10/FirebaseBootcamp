//
//  SignInEmailViewModel.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 29.07.25.
//

import Foundation

@Observable
@MainActor
final class SignInEmailViewModel {
    
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
       try await AuthenticationManager.shared.createUser(email: email, password: password)

    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)

    }
}
