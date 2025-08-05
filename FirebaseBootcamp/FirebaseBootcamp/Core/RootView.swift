//
//  RootView.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 29.07.25.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false

    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    ProfileView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
            
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
