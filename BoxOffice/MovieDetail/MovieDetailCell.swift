//
//  MovieDetailCell.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import UIKit

final class MovieDetailCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(title: String, model: MovieDetailModel?) {
        titleLabel.text = title
        guard let model = model else { return }
        switch title {
        case "개봉일":
            infoLabel.text = model.openDate
        case "상영시간":
            infoLabel.text = model.showTime
        case "장르":
            infoLabel.text = model.genres
        case "관람등급":
            infoLabel.text = model.watchGrade
        case "감독":
            infoLabel.text = model.directors
        case "출연":
            infoLabel.text = model.actors
        case "누적관객":
            infoLabel.text = model.audienceCount
        case "전일대비":
            infoLabel.text = model.audienceInten
        default:
            return
        }
    }
    
    private func setupLayouts() {
        self.contentView.addSubViewsAndtranslatesFalse(self.titleLabel,
                                                       self.infoLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 60),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 20),
            self.infoLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewPreview2: UIViewRepresentable {
    typealias UIViewType = MovieDetailCell
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> MovieDetailCell {
        return MovieDetailCell()
    }
    
    func updateUIView(_ view: MovieDetailCell, context: Context) {
        
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
struct First2Preview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview2().frame(width: 300, height: 10)
        }.previewLayout(.sizeThatFits)
    }
}
#endif
