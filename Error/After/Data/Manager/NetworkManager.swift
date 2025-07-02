//
//  NetworkManager.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

extension String: @retroactive Error { }

final class NetworkManager {
    func execute() async throws {
        throw NetworkError.invalidURL("invalidURL")
    }
}
