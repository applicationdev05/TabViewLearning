//
//  ProfileEditView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject private var nav: TabNavigationState<ProfileRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Profile Screen")
            Button("Save & Pop") {
                nav.pop()
            }
            Button("Go to profile email details") {
                nav.push(.profileEmailDetails)
            }
        }
        .navigationTitle("Edit Profile")
    }
}
