//
//  FirebaseError.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

import Foundation

enum FirebaseError: LocalizedError {
    case save
    case delete
    case fetch
    
    var errorDescription: String? {
        switch self {
        case .save:
            return "저장에 실패했습니다."
        case .delete:
            return "삭제에 실패했습니다."
        case .fetch:
            return "파일 불러오기를 실패했습니다."
        }
    }
}
