//
//  RootView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject private var appState: AppState
    @StateObject private var navigationCoordinator: NavigationCoordinator = NavigationCoordinator()

    var body: some View {
        viewAsPerState()
    }

    @ViewBuilder private func viewAsPerState() -> some View {
        if appState.isLoggedIn {
            MainTabView(selectedTab: $navigationCoordinator.selectedTab)
                .environmentObject(navigationCoordinator)
        } else {
            AuthContainerView()
                .environmentObject(navigationCoordinator)
        }
    }
}
