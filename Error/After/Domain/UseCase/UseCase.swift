//
//  UseCase.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

final class UseCase {
    private let repository: Repository

    init(repository: Repository = Repository()) {
        self.repository = repository
    }

    func executeCoreData() async throws {
        try await repository.fetchCoreData()
    }

    func executeNetwork() async throws {
        try await repository.fetchNetworkData()
    }
}
