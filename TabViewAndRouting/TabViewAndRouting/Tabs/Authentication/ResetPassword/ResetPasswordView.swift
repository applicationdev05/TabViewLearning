//
//  ResetPasswordView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject private var sheetNav: SheetNavigationState<AuthRoute>   /// for internal navigation
    @EnvironmentObject private var authNav: AuthNavigationState   /// to dismiss the entire sheet

    var body: some View {
        VStack(spacing: 20) {

            Button("Confirmation reset password (push)") {
                sheetNav.push(.resetPasswordConfirmation) /// pushes inside sheet
            }

            Button("Close Sheet") {
                authNav.dismissSheet()   /// dismisses the whole sheet
            }
        }
        .navigationTitle("Reset Password")
    }
}
