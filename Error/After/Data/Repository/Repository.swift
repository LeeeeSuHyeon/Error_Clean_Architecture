//
//  Repository.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

final class Repository {
    private let coreDataManager: CoreDataManager
    private let networkManager: NetworkManager

    init(
        coreDataManager: CoreDataManager = CoreDataManager(),
        networkManager: NetworkManager = NetworkManager()
    ) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }

    func fetchCoreData() async throws {
        do {
            try await coreDataManager.execute()
        } catch let error as CoreDataError {
            // 에러 핸들링 (Data Error -> Domain Error 변환)
            throw AppError.coreData(error)
        }

    }

    func fetchNetworkData() async throws {
        do {
            try await networkManager.execute()
        } catch let error as NetworkError {
            // 에러 핸들링 (Data Error -> Domain Error 변환)
            throw AppError.network(error)
        }
    }
}
