//
//  AddMovieReviewViewController.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/20.
//

import UIKit
import Combine
import OSLog

final class AddMovieReviewViewController: UIViewController {

    // MARK: Constants

    static let textViewPlaceHolder = "리뷰 (선택사항)"

    // MARK: UI

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var ratingControl: RatingControl!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var contentTextView: UITextView!
    @IBOutlet private var saveButton: UIBarButtonItem!

    // MARK: Properties

    var review: MovieReview?

    @Published private var username: String = ""
    @Published private var password: String = ""

    private var validateUsername: AnyPublisher<String?, Never> {
        return $username
            .map { username in
                if username.isEmpty { return nil }
                return username
            }
            .eraseToAnyPublisher()
    }

    private var validatePassword: AnyPublisher<String?, Never> {
        return $password
            .map { password in
                let passwordRegex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-z0-9!@#$]{6,20}"
                let isValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
                if !isValid { return nil }
                return password
            }
            .eraseToAnyPublisher()
    }

    private var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validateUsername, validatePassword).map { username, password in
            if username != nil, password != nil { return true }
            return false
        }
        .eraseToAnyPublisher()
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribe()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func subscribe() {
        validatedCredentials
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: Keyboard Notification

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

    // MARK: Action Handlers

    @IBAction
    private func imageViewDidTap() {
        // TODO
    }

    @IBAction
    private func cancelButtonDidTap() {
        dismiss(animated: true)
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem,
              button === saveButton else {
            Logger.ui.debug("The save button was not pressed, cancelling")
            return
        }

        guard let destination = segue.destination as? MovieDetailViewController else { return }

        let movieIdentifier = destination.movieRanking.identifier
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let rating = ratingControl.rating
        let content = contentTextView.text
        review = MovieReview(
            movieIdentifier: movieIdentifier,
            username: username,
            password: password,
            rating: rating,
            content: content
        )
    }

}

// MARK: - UITextFieldDelegate

extension AddMovieReviewViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let replacementText = (text as NSString).replacingCharacters(in: range, with: string)

        if textField == usernameTextField { username = replacementText }
        if textField == passwordTextField { password = replacementText }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            contentTextView.becomeFirstResponder()
        }

        return true
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

        if (boundingRect.size.height + padding * 2 <= textView.frame.size.height) {
            return true
        }
        else {
            return false
        }
    }

}
