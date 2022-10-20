//
//  AddMovieReviewViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import UIKit

final class AddMovieReviewViewController: UIViewController {

    static let textViewPlaceHolder = "리뷰 (선택사항)"
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
        dismiss(animated: true)
    }

}

// MARK: - UITextViewDelegate

extension AddMovieReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Self.textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Self.textViewPlaceHolder
            textView.textColor = .tertiaryLabel
        }
    }
}
