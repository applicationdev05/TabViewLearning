//
//  TabNavigationState.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import SwiftUI
import Combine

protocol StackNavigationRouting: NavigationRouting {
    func popTo(_ route: Route)
    func popTo(_ route: Route, inclusive: Bool)
}

final class TabNavigationState<Route: Hashable>: @MainActor StackNavigationRouting {
    @Published var path: [Route] = []

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    /// Pops back to the last occurrence of the given route.
    /// The target route remains on the stack.
    func popTo(_ route: Route) {
        if let index = path.lastIndex(of: route) {
            path.removeSubrange((index + 1)..<path.count)
        }
    }

    /// Pops back to the last occurrence of the given route, optionally removing it as well.
    /// - Parameter inclusive: If `true`, the target route is also removed.
    func popTo(_ route: Route, inclusive: Bool = false) {
        if let index = path.lastIndex(of: route) {
            let start = inclusive ? index : index + 1
            path.removeSubrange(start..<path.count)
        }
    }
}
