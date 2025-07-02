//
//  BeforeRepository.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

final class BeforeRepository {
    private let coreDataManager: BeforeCoreDataManager
    private let networkManager: BeforeNetworkManager

    init(
        coreDataManager: BeforeCoreDataManager = BeforeCoreDataManager(),
        networkManager: BeforeNetworkManager = BeforeNetworkManager()
    ) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }

    /// CoreData 데이터 가져오기
    func fetchCoreData() async throws {
        try await coreDataManager.execute()
    }

    /// 네트워크 데이터 가져오기
    func fetchNetworkData() async throws {
        try await networkManager.execute()
    }
}
