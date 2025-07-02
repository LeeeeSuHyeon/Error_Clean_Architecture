//
//  AppError.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

/// 모든 에러 타입의 프로토콜 (사용자 친화적인 에러메시지와 디버깅 구분을 위해)
protocol AppErrorProtocol: LocalizedError {
    var errorDescription: String? { get }
    var debugDescription: String { get }
}

/// 앱에서 발생할 수 있는 모든 에러 타입
enum AppError: AppErrorProtocol {
    case network(AppErrorProtocol)
    case coreData(AppErrorProtocol)
    case unknown(Error)
}

extension AppError {
    /// 사용자에게 보여줄 에러 메시지 정의
    var errorDescription: String? {
        switch self {
        case .network(let error), .coreData(let error):
            return error.errorDescription
        case .unknown:
            return "알 수 없는 에러가 발생했습니다."
        }
    }

    /// 개발자 디버깅용 에러 메시지 정의
    var debugDescription: String {
        switch self {
        case .network(let error), .coreData(let error):
            return error.debugDescription
        case .unknown(let error):
            return "unknonwn Error: \(error.localizedDescription)"
        }
    }
}
