//
//  SheetNavigationState.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import Foundation
import Combine

protocol SheetStackNavigationRouting: NavigationRouting {
    func dismiss()
}

final class SheetNavigationState<Route: Hashable>: @MainActor SheetStackNavigationRouting {
    @Published var path: [Route] = []
    @Published var isPresented: Bool = false   /// optional, if we control presentation from here

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

    func dismiss() {
        isPresented = false
        path.removeAll()   /// clean up when dismissed
    }
}
