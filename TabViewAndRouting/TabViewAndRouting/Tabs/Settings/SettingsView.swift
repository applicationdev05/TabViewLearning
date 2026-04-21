//
//  SettingsView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var nav: TabNavigationState<SettingsRoute>

    var body: some View {
        List {
            Button("Account") { nav.push(.account) }
            Button("Privacy") { nav.push(.privacy) }
        }
        .navigationTitle("Settings")
    }
}
