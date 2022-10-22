//
//  MovieReviewViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/21.
//

import Foundation

struct ReviewModel: Codable {
    let movieTitle: String
    let nickname: String
    let password: String
    let starScore: Int?
    let content: String?
}

final class MovieReviewViewModel {
    
    let starValueList = ["1","2","3","4","5"]

    let movieTitle: Observable<String> = .init("")
    let nickname: Observable<String> = .init("")
    let password: Observable<String> = .init("")
    let starScore: Observable<String> = .init("")
    let content: Observable<String> = .init("")

    struct Output {
        let buttonIsEnable: Observable<Bool>
        let passwordIsValid: Observable<Bool>
        let registerReview: Observable<ReviewModel>
    }
    
    func transform() -> Output {
        let passwordValid = passwordValidCheck(text: password.value)
        let finalReview = ReviewModel(movieTitle: movieTitle.value,
                                      nickname: nickname.value,
                                 password: password.value,
                                 starScore: Int(starScore.value),
                                 content: content.value)
        print("finalReview", finalReview)
        return Output(buttonIsEnable: Observable(!nickname.value.isEmpty && !password.value.isEmpty && passwordValid),
                      passwordIsValid: Observable(passwordValid),
                      registerReview: Observable(finalReview))
    }
    
    private func passwordValidCheck(text: String) -> Bool {
        let passwordreg = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$]).{6,20}" // 영어+숫자+특수문자 6 ~ 20
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return predicate.evaluate(with: text)
    }
}


