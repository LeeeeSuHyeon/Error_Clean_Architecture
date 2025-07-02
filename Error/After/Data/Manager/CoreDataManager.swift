//
//  CoreDataManager.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

final class CoreDataManager {
    func execute() async throws {
        throw CoreDataError.entityNotFound("entityNotFound")
    }
}
