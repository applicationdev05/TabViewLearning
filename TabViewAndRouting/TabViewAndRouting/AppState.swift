//
//  AppState.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI
import Combine

/// Global app state – holds authentication flag and persists it to UserDefaults
final class AppState: ObservableObject {

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false {
        didSet { objectWillChange.send() }
    }

    func logout() {
        isLoggedIn = false
        /// Clear any other user‑specific data here (e.g., tokens, profile)
    }
}
