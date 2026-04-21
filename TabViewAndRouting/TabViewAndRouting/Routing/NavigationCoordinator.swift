//
//  NavigationCoordinator.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI
import Combine

final class NavigationCoordinator: ObservableObject {

    @AppStorage("selectedTab") var selectedTab: Int = 0 {
        didSet { objectWillChange.send() }
    }

    /// Each tab’s navigation state
    let homeNavigation = TabNavigationState<HomeRoute>()
    let searchNavigation = TabNavigationState<SearchRoute>()
    let profileNavigation = TabNavigationState<ProfileRoute>()
    let settingsNavigation = TabNavigationState<SettingsRoute>()

    /// Optional: for deep linking that also pushes inside a tab
    /// We can add publishers or methods here
    private let deepLinkSubject = PassthroughSubject<DeepLink, Never>()
    var deepLinkPublisher: AnyPublisher<DeepLink, Never> {
        deepLinkSubject.eraseToAnyPublisher()
    }

    /// Switch tab with optional reset
    func switchToTab(_ tab: Int, resetStack: Bool = true) {
        selectedTab = tab

        if resetStack {
            switch tab {
            case 0: homeNavigation.popToRoot()
            case 1: searchNavigation.popToRoot()
            case 2: profileNavigation.popToRoot()
            case 3: settingsNavigation.popToRoot()
            default: break
            }
        }
    }

    /// Before actual logot state change we should make all the navigationStacks to there root
    func resetAllTabs() {
        homeNavigation.popToRoot()
        searchNavigation.popToRoot()
        profileNavigation.popToRoot()
        settingsNavigation.popToRoot()
        selectedTab = 0 /// setting selected tab to 0 i.e., home
    }

    private func handleDeepLink(_ url: URL) {
        // Parse URL and decide tab + route
        // Example: myapp://home/detail/42
        if url.pathComponents.contains("home") {
            selectedTab = 0
            // Emit event for Home tab to consume
            deepLinkSubject.send(.homeDetail(itemId: 42))
        }
    }

    private func handleNotification(userInfo: [AnyHashable: Any]) {
        /// Similar pattern
    }
}

// Define deep link routes
enum DeepLink {
    case homeDetail(itemId: Int)
    case searchResults(query: String)
    // ... others
}
