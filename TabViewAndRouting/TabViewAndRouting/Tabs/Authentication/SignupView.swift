//
//  SignupView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var authNav: AuthNavigationState

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up Screen")
            Button("Back to Login") {
                authNav.pop()
            }
            Button("Sign Up (demo)") {
                // After signup, go back or directly log in
                authNav.popToRoot()
            }
        }
        .navigationTitle("Sign Up")
    }
}
