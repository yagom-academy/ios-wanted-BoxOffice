//
//  ReviewCell.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/20.
//

import UIKit

protocol ReviewCellDelegate {
  func deleteReview(_ index: Int)
}

class ReviewCell: UITableViewCell {

  static let id = "reviewCell"

  var delegate: ReviewCellDelegate?

  let profile: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "person.crop.circle")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = .darkGray

    return iv
  }()

  let star: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "star.fill")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = .systemYellow

    return iv
  }()

  let rating: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.sizeToFit()
    label.text = "5"

    return label
  }()

  let nickname: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.sizeToFit()
    label.text = "unknown"

    return label
  }()

  let review: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .natural
    label.sizeToFit()
    label.text = "리뷰 내용"
    label.numberOfLines = 0

    return label
  }()

  let delete: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "trash.square"), for: .normal)
    button.tintColor = .systemRed

    return button
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.selectionStyle = .none

    addViews()
    setConstraints()
    addTargets()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension ReviewCell {
  func addViews() {
    [profile, star, rating, nickname, review, delete, ].forEach {
      contentView.addSubview($0)
    }
  }

  func setConstraints() {
    [profile, star, rating, nickname, review, delete, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      profile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      profile.widthAnchor.constraint(equalToConstant: 48),
      profile.heightAnchor.constraint(equalToConstant: 48),
      nickname.centerYAnchor.constraint(equalTo: profile.centerYAnchor),
      nickname.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
      nickname.trailingAnchor.constraint(lessThanOrEqualTo: delete.leadingAnchor),
      star.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 8),
      star.centerXAnchor.constraint(equalTo: profile.centerXAnchor),
//      star.widthAnchor.constraint(equalToConstant: 40),
//      star.heightAnchor.constraint(equalToConstant: 40),
      rating.topAnchor.constraint(equalTo: star.bottomAnchor, constant: 8),
      rating.centerXAnchor.constraint(equalTo: star.centerXAnchor),
      rating.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
      delete.centerYAnchor.constraint(equalTo: nickname.centerYAnchor),
      delete.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      review.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 8),
      review.leadingAnchor.constraint(equalTo: nickname.leadingAnchor),
      review.trailingAnchor.constraint(equalTo: delete.trailingAnchor),
      review.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
    ])
  }

  func addTargets() {
    delete.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
  }

  @objc func deleteButtonPressed() {
    delegate?.deleteReview(self.tag)
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ReviewCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = ReviewCell(frame: .zero)
      return cell
    }.previewLayout(.sizeThatFits)
  }
}
#endif

