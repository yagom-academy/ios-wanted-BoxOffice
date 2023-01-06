//
//  ValidationError.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/06.
//

import Foundation

enum ValidationError: Error {
    case passwordLengthError
    case nickNameEmptyError
    case passwordValidationError
    case passwordRequirmentError
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .passwordLengthError:
            return NSLocalizedString("비밀번호의 길이는 6~20입니다.", comment: "잘못된 비밀번호")
        case .nickNameEmptyError:
            return NSLocalizedString("아이디를 입력해주세요", comment: "잘못된 아이디")
        case .passwordValidationError:
            return NSLocalizedString("비밀번호 양식이 올바르지 않습니다. 소문자, 숫자, !@#$만 사용해주세요.", comment: "잘못된 비밀번호")
        case .passwordRequirmentError:
            return NSLocalizedString("비밀번호에는 소문사 숫자 특수문자(!@#$)가 하나씩 필요합니다.", comment: "잘못된 비밀번호")
            
        }
    }
}
