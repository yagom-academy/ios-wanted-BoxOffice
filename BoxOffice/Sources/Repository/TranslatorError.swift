//
//  TranslatorError.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation

enum TranslatorError: String, LocalizedError {
    case castingError
    case zeroByteData
}

extension TranslatorError {
    var errorDescription: String? {
        switch self {
        case .castingError:
            return "형 변환을 시도하던 중 오류가 발생했습니다."
        case .zeroByteData:
            return "데이터가 정상적으로 수신되지 않았습니다."
        }
    }
}

