//
//  AuthenticationView.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 29.07.25.
//

import SwiftUI

struct AuthenticationView: View {
   // @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView()
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()

        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView()
    }
}
