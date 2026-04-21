//
//  HomeView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var nav: TabNavigationState<HomeRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Home Screen")
            Button("Go to Detail (item 42)") {
                nav.push(.detail(itemId: 42))
            }

            Button("Simulate No Network") {
                NetworkLostWindowManager.shared.showNetworkLostOverlay()
            }
        }
        .navigationTitle("Home")
    }
}
