//
//  NetworkError.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation

/// 각 에러 타입의 세부 에러 타입
enum NetworkError: AppErrorProtocol {
    case invalidURL(Error)
    case failToDecode(Error)
}

extension NetworkError {
    /// 사용자 친화적인 에러 메시지
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "유효하지 않은 URL입니다."
        case .failToDecode:
            "데이터 변환 실패"
        }
    }

    /// 디버깅용 에러 메시지
    var debugDescription: String {
        switch self {
        case .invalidURL(let error):
            "invalidURL: \(error.localizedDescription)"
        case .failToDecode(let error):
            "failToDecode: \(error.localizedDescription)"
        }
    }
}
