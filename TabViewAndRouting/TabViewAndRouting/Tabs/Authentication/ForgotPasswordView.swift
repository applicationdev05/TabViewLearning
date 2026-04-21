//
//  ForgotPasswordView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject private var authNav: AuthNavigationState

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
            Button("Back to Login") {
                authNav.popToRoot()
            }
        }
        .navigationTitle("Forgot Password")
    }
}
