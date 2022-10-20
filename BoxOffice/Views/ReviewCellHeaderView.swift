//
//  ReviewCellHeaderView.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/20.
//

import UIKit

class ReviewCellHeaderView: UITableViewHeaderFooterView {

  static let id = "reviewHeaderView"

  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .center
    label.sizeToFit()
    label.text = "리뷰 별점 평균"

    return label
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
    label.text = "5/5"

    return label
  }()

  let write: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    button.tintColor = .systemPurple

    return button
  }()

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)

    addViews()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ReviewCellHeaderView {
  func addViews() {
    [titleLabel, star, rating, write, ].forEach {
      contentView.addSubview($0)
    }
  }

  func setConstraints() {
    [titleLabel, star, rating, write, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      star.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      star.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
      rating.centerYAnchor.constraint(equalTo: star.centerYAnchor),
      rating.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 8),
      write.centerYAnchor.constraint(equalTo: rating.centerYAnchor),
      write.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
    ])
  }
}
