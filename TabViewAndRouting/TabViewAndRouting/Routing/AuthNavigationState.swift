//
//  AuthNavigationState.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI
import Combine

final class AuthNavigationState: @MainActor NavigationRouting {
    typealias Route = AuthRoute

    @Published var path: NavigationPath = NavigationPath()
    @Published var presentedSheet: AuthSheet?   /// single source for all sheets in AuthSheet enum

    func push(_ route: AuthRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func dismissSheet() {
        presentedSheet = nil
    }

}
