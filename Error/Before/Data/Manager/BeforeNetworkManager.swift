//
//  NetworkManager.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

/// Network Manager
final class BeforeNetworkManager {
    func execute() async throws {
        throw NetworkError.invalidURL("invalidURL")
    }
}
