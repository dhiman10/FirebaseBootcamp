//
//  AuthenticationViewModel.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 31.07.25.
//

import Foundation

@Observable
@MainActor
final class AuthenticationViewModel {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        
        
    }
    
    func signInAnonymous() async throws {
        
        
    }
}
