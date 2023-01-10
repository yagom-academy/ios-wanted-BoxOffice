//
//  Error.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/06.
//

import Foundation

enum FireStoreError: Error {
    case uploadError, readError, deleteError
}

extension FireStoreError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .uploadError:
            return NSLocalizedString("업로드에 실패하였습니다.", comment: "업로드 실패")
        case .readError:
            return NSLocalizedString("데이터 불러오기에 실패하였습니다.", comment: "읽기 실패")
        case .deleteError:
            return NSLocalizedString("삭제에 실패하였습니다.", comment: "삭제 실패")
        }
    }
}
