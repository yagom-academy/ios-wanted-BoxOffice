//
//  AddMovieReviewViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import UIKit

final class AddMovieReviewViewController: UIViewController {

    // MARK: UI

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!

    // MARK: Properties

    var review: MovieReview?

    // MARK: Action Handlers

    @IBAction
    private func imageViewDidTap() {

    }

    @IBAction
    private func cancelButtonDidTap() {

    }

}
