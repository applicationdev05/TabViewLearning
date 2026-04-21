//
//  ProfileTabContainerView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct ProfileTabContainerView: View {
    @ObservedObject var navigationState: TabNavigationState<ProfileRoute>

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            ProfileView()
                .navigationDestination(for: ProfileRoute.self) { route in
                    switch route {
                    case .editProfile:
                        ProfileEditView()
                    case .profileEmailDetails:
                        ProfileEmailDetailsView()
                    // Add more profile routes here as needed
                    }
                }
        }
        .environmentObject(navigationState)
    }
}
