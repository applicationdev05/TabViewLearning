//
//  NetworkLostOverlayView.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 16/04/26.
//

import SwiftUI

struct NetworkLostOverlayView: View {
    @Environment(\.reachabilityManager) var reachability
    @State private var isRetrying: Bool = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
                .onTapGesture { } // prevents tap‑through

            VStack(spacing: 20) {
                Image(systemName: "wifi.slash")
                    .font(.system(size: 60))
                    .foregroundColor(.white)

                Text("No Internet Connection")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("Please check your Wi-Fi or mobile data and try again.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 40)

                Button(action: retryConnection) {
                    if isRetrying {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Retry")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 44)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .disabled(isRetrying)
                .padding(.top, 20)
            }
            .padding()
        }
        .onChange(of: reachability.isConnected) { _, isConnected in
            if isConnected {
                NetworkLostWindowManager.shared.hideNetworkLostOverlay()
            }
        }
    }

    @MainActor
    private func retryConnection() {
        isRetrying = true
        Task { @MainActor in
            // Keep a slight delay so the progress state renders before the check starts.
            try? await Task.sleep(for: .milliseconds(100))
            ReachabilityManager.shared.manualCheckAndUpdate()
            isRetrying = false
        }
    }
}
