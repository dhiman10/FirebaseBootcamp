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
        
        do {
            let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
            print("Sucess")
            print(authDataResult)
        }catch {
            print("Error: \(error)")
        }
        

    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
    }
}
