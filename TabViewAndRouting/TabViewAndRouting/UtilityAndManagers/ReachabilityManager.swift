//
//  ReachabilityManager.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import Foundation
import Network
import Combine
import SwiftUI

protocol ReachabilityManagerProtocol {
    var isConnected: Bool { get }
    func startMonitoring()
    func handlePathUpdate(_ path: NWPath)
    func getConnectionType(from path: NWPath) -> ConnectionType
    func manualCheckAndUpdate()
    func fetchCurrentNetworkState() async -> (isConnected: Bool, type: ConnectionType)
}

enum ConnectionType {
    case wifi, cellular, wiredEthernet, loopback, other, unknown

    var description: String {
        switch self {
        case .wifi: return "Wi-Fi"
        case .cellular: return "Cellular"
        case .wiredEthernet: return "Wired Ethernet"
        case .loopback: return "Loopback"
        case .other: return "Other"
        case .unknown: return "Unknown"
        }
    }
}

/// A reachability manager that monitors network connectivity.
/// Uses Apple's modern `NWPathMonitor` (no third‑party dependencies).
@MainActor
final class ReachabilityManager: ObservableObject, ReachabilityManagerProtocol {

    // MARK: - Singleton
    static let shared = ReachabilityManager()

    // MARK: - Published Properties
    @Published private(set) var isConnected: Bool = true
    @Published private(set) var connectionType: ConnectionType = .unknown

    // MARK: - Private Properties
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityManagerQueue")

    // MARK: - Init
    private init() {
        startMonitoring()
    }

    deinit {
        monitor.cancel()
    }

    // MARK: - Monitoring
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            // Hop to MainActor safely (Swift 6 requirement)
            Task { @MainActor in
                self?.handlePathUpdate(path)
            }
        }

        monitor.start(queue: queue)
    }

    // MARK: - Path Handling
    internal func handlePathUpdate(_ path: NWPath) {
        let newStatus = path.status == .satisfied
        let newType = getConnectionType(from: path)

        // Always update connection type
        connectionType = newType

        isConnected = newStatus

        if !newStatus {
            // Lost connection
            NetworkLostWindowManager.shared.showNetworkLostOverlay()
        } else {
            // Restored connection
            NetworkLostWindowManager.shared.hideNetworkLostOverlay()
        }
    }

    // MARK: - Helpers
    internal func getConnectionType(from path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
        } else if path.usesInterfaceType(.loopback) {
            return .loopback
        } else {
            return .other
        }
    }

    /// Manually check current connectivity and update state.
    /// Call this from retry
    func manualCheckAndUpdate() {
        Task {
            let result = await fetchCurrentNetworkState()
            let previous = self.isConnected
            self.isConnected = result.isConnected
            self.connectionType = result.type

            if previous != result.isConnected {
                if result.isConnected {
                    NetworkLostWindowManager.shared.hideNetworkLostOverlay()
                } else {
                    NetworkLostWindowManager.shared.showNetworkLostOverlay()
                }
            } else if result.isConnected && NetworkLostWindowManager.shared.isOverlayShowing {
                NetworkLostWindowManager.shared.hideNetworkLostOverlay()
            }
        }
    }

    internal func fetchCurrentNetworkState() async -> (isConnected: Bool, type: ConnectionType) {
        await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()

            monitor.pathUpdateHandler = { [weak self] path in
                guard let self = self else { return }
                let isConnected = path.status == .satisfied
                /// Hop to MainActor safely
                Task { @MainActor in
                    let type = self.getConnectionType(from: path)
                    continuation.resume(returning: (isConnected, type))
                    monitor.cancel()
                }
            }
            monitor.start(queue: DispatchQueue.global())
        }
    }
}

// MARK: - SwiftUI Environment Integration
extension EnvironmentValues {
    @Entry var reachabilityManager = ReachabilityManager.shared
}

/// Optional: View modifier to observe reachability
struct ReachabilityObserverModifier: ViewModifier {
    @StateObject private var manager = ReachabilityManager.shared

    func body(content: Content) -> some View {
        content
            .environment(\.reachabilityManager, manager)
            .onChange(of: manager.isConnected) { _, isConnected in
                /// Optional: handle global network changes (e.g., show banner)
                if !isConnected {
                    debugPrint("Network lost")
                } else {
                    debugPrint("Network restored")
                }
            }
    }
}

extension View {
    func observeReachability() -> some View {
        modifier(ReachabilityObserverModifier())
    }
}
