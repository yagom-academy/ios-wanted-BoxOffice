//
//  ReviewListViewModel.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/05.
//

import Foundation
import Combine

protocol ReviewListViewModelInputInterface: AnyObject {
    func onViewDidLoad()
    func deleteComment(comment: Comment)
}

protocol ReviewListViewModelOutPutInterface: AnyObject {
    var commentPublisher: PassthroughSubject<[Comment], Never> { get }
    var errorPublisher: PassthroughSubject<Error?, Never> { get }
}

protocol ReviewListViewModelInterface: AnyObject {
    var input: ReviewListViewModelInputInterface { get }
    var output: ReviewListViewModelOutPutInterface { get }
}

final class ReviewListViewModel: ReviewListViewModelInterface, ReviewListViewModelInputInterface {
    private let detailBoxOffice: CustomBoxOffice
    private let commentManager: CommentManager
    
    // MARK: ReviewListViewModelInterface
    var input: ReviewListViewModelInputInterface { self }
    
    var output: ReviewListViewModelOutPutInterface { self }

    // MARK: ReviewListViewModelOutPutInterface
    
    var commentPublisher = PassthroughSubject<[Comment], Never>()
    var errorPublisher = PassthroughSubject<Error?, Never>()
    
    private var commentArray: [Comment] = []
    
    init(detailBoxOffice: CustomBoxOffice, CommentManager: CommentManager = CommentManager()) {
        self.detailBoxOffice = detailBoxOffice
        self.commentManager = CommentManager
    }
    
    private func requestComments() {
        let movieCd = detailBoxOffice.boxOffice.movieCode
        commentManager.getComments(movieCd: movieCd) { [weak self] comments, error in
            if let comments = comments, error == nil {
                self?.commentArray = comments
                self?.commentPublisher.send(self?.commentArray ?? [])
            } else {
                self?.errorPublisher.send(error)
            }
        }
    }
}

extension ReviewListViewModel: ReviewListViewModelOutPutInterface {
    func onViewDidLoad() {
        requestComments()
    }
    func deleteComment(comment: Comment) {
        commentManager.deleteComment(comment: comment) { [weak self] error in
            if error == nil {
                guard let index = self?.commentArray.firstIndex(of: comment) else {
                    return
                }
                self?.commentArray.remove(at: index)
                self?.commentPublisher.send(self?.commentArray ?? [])
            } else {
                self?.errorPublisher.send(error)
            }
        }
    }
}
