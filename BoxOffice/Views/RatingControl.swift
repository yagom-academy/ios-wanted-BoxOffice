//
//  RatingControl.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {

    // MARK: Properties

    private var ratingButtons = [UIButton]()

    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }

    @IBInspectable
    var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable
    var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        setupButtons()
    }

    // MARK: Action Handlers

    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    // MARK: Private Methods

    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()

        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")

        for index in 0..<starCount {
            let button = UIButton()

            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

            button.accessibilityLabel = "Set \(index + 1) star rating"

            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)

            addArrangedSubview(button)

            ratingButtons.append(button)
        }

        updateButtonSelectionStates()
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating

            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }

            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }

            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
