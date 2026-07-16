//
//  AuthContainerView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI

struct AuthContainerView: View {
    /// Own its navigation state – recreated when view disappears, which is fine for auth
    @StateObject private var navigationState = AuthNavigationState()

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            LoginView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .signup:
                        SignupView()
                    case .forgotPassword:
                        ForgotPasswordView()
                    case .resetPassword:
                       ResetPasswordView()
                    case .resetPasswordConfirmation:
                        ResetPasswordConfirmationView()
                    }
                }
        }
        .environmentObject(navigationState)
        .sheet(item: $navigationState.presentedSheet) { sheet in
            switch sheet {
            case .resetPassword:
                ResetPasswordSheetContainer()
                    .environmentObject(navigationState)
            case .termsAndConditions:
                EmptyView()
            }
        }
    }
}
