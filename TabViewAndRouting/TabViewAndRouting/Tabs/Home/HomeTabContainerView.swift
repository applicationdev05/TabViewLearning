//
//  HomeTabContainerView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct HomeTabContainerView: View {
    @ObservedObject var navigationState: TabNavigationState<HomeRoute>

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .detail(let itemId):
                        HomeDetailView(itemId: itemId)
                    }
                }
        }
        .environmentObject(navigationState)
    }
}
