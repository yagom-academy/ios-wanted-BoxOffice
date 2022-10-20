//
//  AddMovieReviewViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import UIKit
import OSLog

final class AddMovieReviewViewController: UIViewController {

    static let textViewPlaceHolder = "리뷰 (선택사항)"
    // MARK: UI

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!

    // MARK: Properties

    var review: MovieReview?

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Action Handlers

    @IBAction
    private func imageViewDidTap() {
        Logger.ui.debug(#function)

    }

    @IBAction
    private func cancelButtonDidTap() {
        dismiss(animated: true)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.verticalScrollIndicatorInsets = contentInsets
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.verticalScrollIndicatorInsets = contentInsets
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // textView의 높이로 입력 글자수 제한
        let combinedText = (textView.text as NSString).replacingCharacters(in: range, with: text)

        let attributedText = NSMutableAttributedString(string: combinedText)
        attributedText.addAttribute(
            NSAttributedString.Key.font,
            value: textView.font as Any,
            range: NSMakeRange(0, attributedText.length)
        )

        let padding = textView.textContainer.lineFragmentPadding

        let boundingSize = CGSizeMake(textView.frame.size.width - padding * 2, CGFloat.greatestFiniteMagnitude)

        let boundingRect = attributedText.boundingRect(
            with: boundingSize,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            context: nil
        )

        if (boundingRect.size.height + padding * 2 <= textView.frame.size.height){
            return true
        }
        else {
            return false
        }
    }

}
