//
//  NetworkManager.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 03/06/2025.
//

import Foundation
import Reachability

class NetworkManager {
    static let shared = NetworkManager()

    private let reachability = try! Reachability()

    var isConnected: Bool {
        return reachability.connection != .unavailable
    }

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        reachability.whenReachable = { _ in
            print("Network reachable")
        }
        reachability.whenUnreachable = { _ in
            print("Network not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    deinit {
        reachability.stopNotifier()
    }
}
