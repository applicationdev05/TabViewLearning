//
//  ResetPasswordConfirmationView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI

struct ResetPasswordConfirmationView: View {
    @EnvironmentObject private var sheetNav: SheetNavigationState<AuthRoute>
    @EnvironmentObject private var authNav: AuthNavigationState

    var body: some View {
        VStack(spacing: 20) {
            Text("Password Reset")
                .font(.largeTitle)

            Text("Your password has been successfully reset.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Done") {
                /// Dismiss the entire sheet after completion
                authNav.dismissSheet()
            }
            .buttonStyle(.borderedProminent)

            Button("Back") {
                sheetNav.pop()
            }
        }
        .padding()
        .navigationTitle("Confirmation")
    }
}
