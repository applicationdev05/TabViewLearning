//
//  NetworkLostWindowManager.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI
import UIKit

protocol NetworkLostWindowManagerProtocol {
    var isOverlayShowing: Bool { get }
    func showNetworkLostOverlay()
    func hideNetworkLostOverlay()
}

final class NetworkLostWindowManager: NetworkLostWindowManagerProtocol {
    static let shared = NetworkLostWindowManager()
    private var networkLostWindow: UIWindow?
    private(set) var isOverlayShowing = false

    private init() {}

    func showNetworkLostOverlay() {
        /// Hide existing first
        hideNetworkLostOverlay()
        /// Get the active window scene
        guard let activeScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene else {
            debugPrint("No UIWindowScene found")
            return
        }

        let hostingController = UIHostingController(rootView: NetworkLostOverlayView())
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.view.backgroundColor = .clear

        let window = UIWindow(windowScene: activeScene)
        window.rootViewController = hostingController
        window.windowLevel = .alert + 1 /// on top of ever current window
        window.backgroundColor = .clear
        window.isHidden = false
        window.makeKeyAndVisible()

        networkLostWindow = window
        isOverlayShowing = true
    }

    func hideNetworkLostOverlay() {
        networkLostWindow?.isHidden = true
        networkLostWindow = nil
        isOverlayShowing = false
    }
}
