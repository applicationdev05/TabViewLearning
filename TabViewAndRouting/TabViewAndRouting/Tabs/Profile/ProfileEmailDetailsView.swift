//
//  ProfileEmailDetailsView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct ProfileEmailDetailsView: View {

    @EnvironmentObject private var nav: TabNavigationState<ProfileRoute>

    var body: some View {
        VStack {
            Button("pop to edit profile") {
                nav.popTo(.editProfile)
            }
        }.navigationTitle("Profile Email Details")
    }
}
