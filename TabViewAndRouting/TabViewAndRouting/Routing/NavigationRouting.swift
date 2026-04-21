//
//  NavigationRouting.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import Foundation

@MainActor
protocol NavigationRouting: ObservableObject {
    associatedtype Route: Hashable

    func push(_ route: Route)
    func pop()
    func popToRoot()
}
