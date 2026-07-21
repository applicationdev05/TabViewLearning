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
        viewAsPerState().onAppear {
            logBaseURL()
        }
    }

    private func logBaseURL() {
        guard let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL not found")
        }
        debugPrint(apiURL)
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
