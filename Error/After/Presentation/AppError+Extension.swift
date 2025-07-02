//
//  AppError+Extension.swift
//  Error
//
//  Created by 이수현 on 7/2/25.
//

import Foundation

extension AppError {
    /// Error Alert에 표시될 Title 설정
    var alertTitle: String {
        switch self {
        case .network:
            "네트워크 에러"
        case .coreData:
            "저장소 에러"
        case .unknown:
            "알 수 없는 에러"
        }
    }
}
