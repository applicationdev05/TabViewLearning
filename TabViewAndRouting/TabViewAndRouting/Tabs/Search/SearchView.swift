//
//  SearchView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var nav: TabNavigationState<SearchRoute>
    @State private var query: String = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Search") {
                // action
            }
        }
        .navigationTitle("Search")
    }
}
