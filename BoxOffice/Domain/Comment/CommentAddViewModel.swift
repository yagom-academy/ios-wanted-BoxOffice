//
//  CommentAddViewModel.swift
//  BoxOffice
//
//  Created by 곽우종 on 2023/01/05.
//

import Foundation
import Combine

protocol CommentAddViewModelInputInterface: AnyObject {
    func registerComment(input: CommentViewController.InputValue)
}

protocol CommentAddViewModelOutPutInterface: AnyObject {
    var isloadingPublisher: PassthroughSubject<Bool, Never> { get }
    var errorPublisher: PassthroughSubject<String, Never> { get }
}

protocol CommentAddViewModelInterface: AnyObject {
    var input: CommentAddViewModelInputInterface { get }
    var output: CommentAddViewModelOutPutInterface { get }
}

final class CommentAddViewModel: CommentAddViewModelInterface, CommentAddViewModelOutPutInterface {
    var input: CommentAddViewModelInputInterface { self }
    var output: CommentAddViewModelOutPutInterface { self }
    private var commentManger: CommentManagerable
    var errorPublisher = PassthroughSubject<String, Never>()
    var isloadingPublisher = PassthroughSubject<Bool, Never>()
    private var detailBoxOffice: DetailBoxOffice
    private let validateNumber:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    private let validateEnglish:[Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private let validateSpecial:[Character] = ["!","@","#","$"]
    
    init(commentManger: CommentManagerable = CommentManager(), detailBoxOffice: DetailBoxOffice) {
        self.commentManger = commentManger
        self.detailBoxOffice = detailBoxOffice
    }
}

extension CommentAddViewModel:  CommentAddViewModelInputInterface{
    
    func registerComment(input: CommentViewController.InputValue) {
        
        if let error = checkValidation(input: input){
            errorPublisher.send(error.localizedDescription)
            return
        }
        
        let comment = Comment(
            movieCd: detailBoxOffice.movieCode,
            nickName: input.nickName ?? "",
            password: input.password ?? "",
            rate: input.starRate ?? 0,
            info: input.info ?? "",
            picture: input.image?.toString ?? ""
        )
        
        isloadingPublisher.send(true)
        commentManger.uploadComment(comment: comment) { [weak self] error in
            if let error = error {
                self?.errorPublisher.send(error.localizedDescription)
            } else {
                self?.isloadingPublisher.send(false)
            }
        }
    }
    
    private func checkValidation(input: CommentViewController.InputValue) -> ValidationError? {
        if input.nickName == "" || input.nickName == nil {
            return .nickNameEmptyError
        }
        
        if let error = checkPasswordValidation(input.password) {
            return error
        }
        return nil
    }
    
    private func checkPasswordValidation(_ password: String?) -> ValidationError? {
        guard let password = password,
              (password.count >= 6 && password.count <= 20 ) else {
            return ValidationError.passwordLengthError
        }
        var checkNumber = false
        var checkEnglish = false
        var checkSpecial = false
        let checkSatisfy = password.allSatisfy({
            if (validateNumber.contains($0)) {
                checkNumber = true
            }
            if (validateEnglish.contains($0)){
                checkEnglish = true
            }
            if (validateSpecial.contains($0)){
                checkSpecial = true
            }
            return validateNumber.contains($0) || validateEnglish.contains($0) || validateSpecial.contains($0)
        })
        
        guard checkSatisfy && checkNumber && checkEnglish && checkSpecial else {
            return ValidationError.passwordValidationError
        }
        return nil
    }
}

enum ValidationError: Error {
    case passwordLengthError
    case nickNameEmptyError
    case passwordValidationError
}
