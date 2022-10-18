//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/18.
//

import UIKit

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

    return label
  }()

  let movieTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title2)
    label.text = "영화제목"

    return label
  }()

  let openDate: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "개봉일"

    return label
  }()

  let audienceCount: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "관객수"

    return label
  }()

  let labelStack: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical

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

}

extension MovieListCell {
  func addViews() {
    [movieTitle, openDate, audienceCount].forEach { labelStack.addArrangedSubview($0) }
    [poster, ranking, labelStack, newTag, rankDiff, rankUpDown, ].forEach {
      contentView.addSubview($0)
    }
  }

  func setConstraints() {
    [poster, ranking, labelStack, newTag, rankDiff, rankUpDown, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      poster.widthAnchor.constraint(equalToConstant: 100),
      poster.heightAnchor.constraint(equalToConstant: 144),
      ranking.topAnchor.constraint(equalTo: poster.topAnchor, constant: 12),
      ranking.leadingAnchor.constraint(equalTo: poster.leadingAnchor, constant: 12),
      labelStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      labelStack.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
      rankUpDown.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      rankUpDown.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
      rankDiff.centerYAnchor.constraint(equalTo: rankUpDown.centerYAnchor),
      rankDiff.trailingAnchor.constraint(equalTo: rankUpDown.leadingAnchor, constant: -6),
      newTag.centerYAnchor.constraint(equalTo: rankDiff.centerYAnchor),
      newTag.trailingAnchor.constraint(equalTo: rankDiff.leadingAnchor, constant: -6),
      newTag.widthAnchor.constraint(equalToConstant: 40),

    ])
  }

  func setPoster(_ img: UIImage) {
    self.poster.image = img
  }

  func setLabels(title: String, date: String, audiCnt: String, diff: String) {
    self.movieTitle.text = title
    self.openDate.text = date
    self.audienceCount.text = "\(audiCnt) 명 관람"
    self.rankDiff.text = diff
  }

  func changeRankUpDown(_ up: Bool) {
    if up {
      self.rankUpDown.image = UIImage(systemName: "arrowtriangle.up.square.fill")
      self.rankUpDown.tintColor = .systemRed
    } else {
      self.rankUpDown.image = UIImage(systemName: "arrowtriangle.down.square.fill")
      self.rankUpDown.tintColor = .systemBlue
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

