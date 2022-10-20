//
//  MovieReviewViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/21.
//

import Foundation

final class MovieReviewViewModel {
    
    let starValueList = ["1","2","3","4","5"]

    let nickname: Observable<String> = .init("")
    let password: Observable<String> = .init("")
    let starScore: Observable<String> = .init("")
    let content: Observable<String> = .init("")
    
    struct Output {
        let buttonIsEnable: Observable<Bool>
        let passwordIsValid: Observable<Bool>
    }
    
    func transform() -> Output {
        Output(buttonIsEnable: Observable(!nickname.value.isEmpty && !password.value.isEmpty),
               passwordIsValid: Observable(passwordValidCheck(text: password.value)))
    }
    
    private func passwordValidCheck(text: String) -> Bool {
        let passwordreg = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$]).{6,20}" // 영어+숫자+특수문자 6 ~ 20
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return predicate.evaluate(with: text)
    }
}


