//
//  SettingsTabContainerView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct SettingsTabContainerView: View {
    @ObservedObject var navigationState: TabNavigationState<SettingsRoute>

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            SettingsView()
                .navigationDestination(for: SettingsRoute.self) { route in
                    switch route {
                    case .account:
                        AccountSettingsView()   // replace with your actual view
                    case .privacy:
                        PrivacySettingsView()   // replace with your actual view
                    }
                }
        }
        .environmentObject(navigationState)
    }
}
