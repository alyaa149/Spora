//
//  NetworkManager.swift
//  SporaApp
//
//  Created by Habiba Elhadi on 03/06/2025.
//

import Foundation
import Network

class NetworkManager {
    static func isInternetAvailable(completion: @escaping (Bool) -> Void) {
            let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "InternetConnectionMonitor")
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    completion(true)
                } else {
                    completion(false)
                }
                monitor.cancel()
            }
            monitor.start(queue: queue)
        }
}
