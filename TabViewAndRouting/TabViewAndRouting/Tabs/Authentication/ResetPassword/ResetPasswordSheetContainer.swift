//
//  ResetPasswordSheetContainer.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI

struct ResetPasswordSheetContainer: View {
    @StateObject private var sheetNav = SheetNavigationState<AuthRoute>()   /// Use AuthRoute for pushes
    @EnvironmentObject private var authNav: AuthNavigationState   /// to dismiss the sheet

    var body: some View {
        NavigationStack(path: $sheetNav.path) {
            ResetPasswordView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .resetPassword:
                        ResetPasswordView()
                    case .resetPasswordConfirmation:
                        ResetPasswordConfirmationView()
                    default:
                        EmptyView()
                    }
                }
        }
        .environmentObject(sheetNav)   /// child views use this for navigation inside sheet
        .onDisappear {
            /// Optional: clean up when sheet is dismissed
        }
    }
}
