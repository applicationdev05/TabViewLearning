//
//  ProfileView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var nav: TabNavigationState<ProfileRoute>
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var navigationCoordinator: NavigationCoordinator /// navigation coordinator

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
            Button("Edit Profile") {
                nav.push(.editProfile)
                // navigationCoordinator.profileNavigation.push(.editProfile)
            }
            Button("Jump to home") {
                navigationCoordinator.switchToTab(0, resetStack: false)
            }
            Button("Logout") {
                navigationCoordinator.resetAllTabs()
                appState.logout()
            }
        }
        .navigationTitle("Profile")
    }
}
