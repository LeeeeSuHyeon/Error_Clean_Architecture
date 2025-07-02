//
//  CoreDataError.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

/// 각 에러 타입의 세부 에러 타입
enum CoreDataError: AppErrorProtocol {
    case entityNotFound(Error)
    case readError(Error)
}

extension CoreDataError {
    /// 사용자 친화적인 에러 메시지
    var errorDescription: String? {
        switch self {
        case .entityNotFound:
            "데이터 접근에 실패했습니다."
        case .readError:
            "데이터를 읽어오는 데 실패했습니다."
        }
    }

    /// 디버깅용 에러 메시지
    var debugDescription: String {
        switch self {
        case .entityNotFound(let error):
            "entityNotFound: \(error.localizedDescription)"
        case .readError(let error):
            "readError: \(error.localizedDescription)"
        }
    }
}
