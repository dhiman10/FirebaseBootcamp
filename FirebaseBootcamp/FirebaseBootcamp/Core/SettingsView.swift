//
//  SettingsView.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 29.07.25.
//

import SwiftUI

@Observable
@MainActor
final class SettingsViewModel {
    
    
    func signOut() throws  {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @State private var viewModel =  SettingsViewModel()
    @Binding var showSignInView: Bool

    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    }catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
