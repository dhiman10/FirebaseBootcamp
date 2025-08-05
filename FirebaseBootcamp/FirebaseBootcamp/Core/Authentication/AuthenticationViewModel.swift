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
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInApple() async throws {
        
        
    }
    
    func signInAnonymous() async throws {
        let authDataResult =   try await AuthenticationManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
