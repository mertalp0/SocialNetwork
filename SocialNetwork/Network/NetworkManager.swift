//
//  NetworkManager.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import Foundation
import SystemConfiguration

// MARK: - NetworkManager
class NetworkManager {
    
    // MARK: - Internet Connectivity Check
    static func isConnectedToInternet() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
}
