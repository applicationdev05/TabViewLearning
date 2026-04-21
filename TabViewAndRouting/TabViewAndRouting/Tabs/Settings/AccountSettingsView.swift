//
//  AccountSettingsView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct AccountSettingsView: View {
    @EnvironmentObject private var nav: TabNavigationState<SettingsRoute>

    var body: some View {
        VStack {
            Text("Account settings go here")
            Button("Back") { nav.pop() }
        }
        .navigationTitle("Account")
    }
}
