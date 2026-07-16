//
//  LoginView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authNav: AuthNavigationState
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text("Login Screen")
                .font(.largeTitle)
            Button("Sign Up") {
                authNav.push(.signup)
            }
            Button("Forgot Password?") {
                authNav.push(.forgotPassword)
            }
            Button("Reset Password?") {
                authNav.presentedSheet = .resetPassword
            }
            Button("Login (demo)") {
                // Simulate login success
                appState.isLoggedIn = true
            }
        }
        .navigationTitle("Login")
    }
}
