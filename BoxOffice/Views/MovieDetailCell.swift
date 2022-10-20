//
//  MovieDetailCell.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/20.
//

import UIKit

class MovieDetailCell: UITableViewCell {
  static let id = "detailCell"

  let poster: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "photo")
    iv.contentMode = .scaleAspectFit

    return iv
  }()

  let ranking: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.text = "1"
    label.sizeToFit()

    return label
  }()

  let audienceCount: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.text = "관객수"
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let newTag: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "new")
    iv.contentMode = .scaleAspectFit

    return iv
  }()

  let rankDiff: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.text = "0"
    label.sizeToFit()

    return label
  }()

  let rankUpDown: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "arrowtriangle.up.square.fill")
    iv.tintColor = .systemRed

    return iv
  }()

  let showTime: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "105분"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let openDate: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "개봉일"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let productionYear: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "제작연도"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let director: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "감독"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let genre: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "장르"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let grade: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "등급"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  let horizontal1: UIStackView = {
    let sv = UIStackView()
    sv.axis = .horizontal
    sv.distribution = .fill

    return sv
  }()

  let horizontal2: UIStackView = {
    let sv = UIStackView()
    sv.axis = .horizontal
    sv.distribution = .fill

    return sv
  }()

  let vertical: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.distribution = .fill

    return sv
  }()

  let actors: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "출연진\nsdfjaskdjflaksdjf;ljasdlfjasl;djf"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()

    return label
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

extension MovieDetailCell {
  func addViews() {
    [showTime, openDate, productionYear].forEach {
      horizontal1.addArrangedSubview($0)
    }

    [director, genre, grade].forEach {
      horizontal2.addArrangedSubview($0)
    }

    [horizontal1, horizontal2].forEach {
      vertical.addArrangedSubview($0)
    }

    [poster, ranking, audienceCount, newTag, rankDiff, rankUpDown, vertical, actors, ].forEach {
      contentView.addSubview($0)
    }
  }

  func setConstraints() {
    [poster, ranking, audienceCount, newTag, rankDiff, rankUpDown, vertical, actors, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      poster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      poster.widthAnchor.constraint(equalToConstant: 100),
      poster.heightAnchor.constraint(equalToConstant: 144),
      ranking.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 10),
//      ranking.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
      ranking.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      audienceCount.topAnchor.constraint(equalTo: ranking.bottomAnchor, constant: 8),
//      audienceCount.leadingAnchor.constraint(equalTo: ranking.leadingAnchor),
      audienceCount.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      newTag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
      newTag.centerYAnchor.constraint(equalTo: ranking.centerYAnchor),
      newTag.widthAnchor.constraint(equalToConstant: 40),
      rankUpDown.trailingAnchor.constraint(equalTo: newTag.trailingAnchor),
      rankUpDown.centerYAnchor.constraint(equalTo: audienceCount.centerYAnchor),
      rankUpDown.widthAnchor.constraint(equalToConstant: 32),
      rankUpDown.heightAnchor.constraint(equalToConstant: 32),
      rankDiff.centerYAnchor.constraint(equalTo: rankUpDown.centerYAnchor),
      rankDiff.trailingAnchor.constraint(equalTo: rankUpDown.leadingAnchor, constant: -10),
      audienceCount.trailingAnchor.constraint(lessThanOrEqualTo: rankDiff.leadingAnchor),

      vertical.topAnchor.constraint(equalTo: audienceCount.bottomAnchor, constant: 20),
      vertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
      vertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

      actors.topAnchor.constraint(equalTo: vertical.bottomAnchor, constant: 20),
      actors.leadingAnchor.constraint(equalTo: vertical.leadingAnchor),
      actors.trailingAnchor.constraint(equalTo: vertical.trailingAnchor),

      actors.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),


    ])
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MovieDetailCellPreview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = MovieDetailCell(frame: .zero)
      return cell
    }.previewLayout(.sizeThatFits)
  }
}
#endif

