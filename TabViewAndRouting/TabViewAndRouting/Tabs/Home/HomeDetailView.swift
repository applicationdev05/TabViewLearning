//
//  HomeDetailView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct HomeDetailView: View {
    let itemId: Int
    @EnvironmentObject private var nav: TabNavigationState<HomeRoute>

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail for item \(itemId)")
            Button("Pop") {
                nav.pop()
            }
            Button("Pop to Root") {
                nav.popToRoot()
            }
        }
        .navigationTitle("Detail")
        .toolbar(.hidden, for: .tabBar)
    }
}
