//
//  MainTabView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeTabContainerView(navigationState: coordinator.homeNavigation)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)

            SearchTabContainerView(navigationState: coordinator.searchNavigation)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)

            ProfileTabContainerView(navigationState: coordinator.profileNavigation)
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(2)

            SettingsTabContainerView(navigationState: coordinator.settingsNavigation)
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(3)
        }
    }
}
