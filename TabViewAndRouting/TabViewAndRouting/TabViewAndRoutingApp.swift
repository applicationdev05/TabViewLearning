//
//  TabViewAndRoutingApp.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

@main
struct TabViewAndRoutingApp: App {

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .observeReachability() /// enabling Reachability for whole app
        }
    }
}
