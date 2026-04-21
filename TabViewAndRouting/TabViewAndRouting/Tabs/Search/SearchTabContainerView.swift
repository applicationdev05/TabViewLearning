//
//  SearchTabContainerView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct SearchTabContainerView: View {
    @ObservedObject var navigationState: TabNavigationState<SearchRoute>

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            SearchView()
                .navigationDestination(for: SearchRoute.self) { route in
                    switch route {
                    case .results( _ ):
                        SearchView()
                    }
                }
        }
        .environmentObject(navigationState)
    }
}
