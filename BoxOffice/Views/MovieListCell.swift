//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/18.
//

import UIKit

enum UpDown {
  case nothing
  case up
  case down
}

class MovieListCell: UITableViewCell {
  static let id = "movieCell"

  let poster: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "photo")
    iv.contentMode = .scaleAspectFit

    return iv
  }()

  let ranking: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.text = "1"
    label.adjustsFontForContentSizeCategory = true

    return label
  }()

  let movieTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title2)
    label.text = "영화제목"
    label.numberOfLines = 2
    label.adjustsFontForContentSizeCategory = true

    return label
  }()

  let openDate: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "개봉일"
    label.numberOfLines = 0
    label.adjustsFontForContentSizeCategory = true

    return label
  }()

  let audienceCount: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "관객수"
    label.numberOfLines = 0
    label.adjustsFontForContentSizeCategory = true

    return label
  }()

  let labelStack: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.distribution = .fill

    return sv
  }()

  let newTag: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "new")
    iv.contentMode = .scaleAspectFit

    return iv
  }()

  let rankDiff: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "0"
    label.adjustsFontForContentSizeCategory = true

    return label
  }()

  let rankUpDown: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "arrowtriangle.up.square.fill")
    iv.tintColor = .systemRed

    return iv
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.selectionStyle = .none

    addViews()
    setConstraints()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.poster.image = nil
    self.newTag.isHidden = true
  }
}

extension MovieListCell {
  func addViews() {
    [ranking, movieTitle, openDate, audienceCount, ].forEach { labelStack.addArrangedSubview($0) }
    [labelStack, poster, newTag, rankDiff, rankUpDown, ].forEach {
      contentView.addSubview($0)
    }
  }

  func setConstraints() {
    [labelStack, poster, newTag, rankDiff, rankUpDown, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // TODO: - Poster 높이 제약 수정하기
    NSLayoutConstraint.activate([
      labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      labelStack.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
      labelStack.trailingAnchor.constraint(lessThanOrEqualTo: rankDiff.leadingAnchor),
      poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      poster.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
      poster.heightAnchor.constraint(lessThanOrEqualTo: poster.widthAnchor, multiplier: 1.4),
      rankUpDown.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      rankUpDown.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
      rankUpDown.widthAnchor.constraint(equalToConstant: 32),
      rankUpDown.heightAnchor.constraint(equalToConstant: 32),
      rankDiff.centerYAnchor.constraint(equalTo: rankUpDown.centerYAnchor),
      rankDiff.trailingAnchor.constraint(equalTo: rankUpDown.leadingAnchor, constant: -6),
      newTag.bottomAnchor.constraint(equalTo: rankUpDown.topAnchor, constant: -10),
      newTag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      newTag.widthAnchor.constraint(equalToConstant: 40),
    ])
  }

  func setPoster(_ img: UIImage) {
    self.poster.image = img
  }

  func setLabels(rank: String, title: String, date: String, audiCnt: String, diff: String) {
    self.ranking.text = "\(rank)위"
    self.movieTitle.text = title
    self.openDate.text = "개봉일 : \(date)"
    self.audienceCount.text = "\(audiCnt)명 관람"
    self.rankDiff.text = diff
  }

  func changeRankUpDown(_ state: UpDown) {
    switch state {
    case .nothing:
      self.rankUpDown.image = UIImage(systemName: "minus.square")
      self.rankUpDown.tintColor = .black
    case .up:
      self.rankUpDown.image = UIImage(systemName: "arrowtriangle.up.square.fill")
      self.rankUpDown.tintColor = .systemRed
    case .down:
      self.rankUpDown.image = UIImage(systemName: "arrowtriangle.down.square.fill")
      self.rankUpDown.tintColor = .systemBlue
    }
  }

  func toggleNewTag(_ on: Bool) {
    if on {
      self.newTag.isHidden = false
    } else {
      self.newTag.isHidden = true
    }
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MovieListCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = MovieListCell(frame: .zero)
      return cell
    }.previewLayout(.sizeThatFits)
  }
}
#endif

