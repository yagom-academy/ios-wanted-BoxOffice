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
        label.text = "관객수"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "~~명"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
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
        case "개요":
            infoLabel.text = "\(model.showTime) | \(model.openDate)"
        case "장르":
            infoLabel.text = model.genres
        case "감독":
            infoLabel.text = model.directors
        case "출연":
            infoLabel.text = model.actors
        case "관객수":
            infoLabel.text = model.audienceCount
        case "관람등급":
            infoLabel.text = model.watchGrade
        case "랭크":
            infoLabel.text = "\(model.rankOldAndNew) | \(model.audienceInten)"
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
            self.infoLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            self.infoLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}


//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct UIViewPreview2: UIViewRepresentable {
//    typealias UIViewType = MovieDetailCell
//
//    // MARK: - UIViewRepresentable
//    func makeUIView(context: Context) -> MovieDetailCell {
//        return MovieDetailCell()
//    }
//
//    func updateUIView(_ view: MovieDetailCell, context: Context) {
//
//    }
//}
//#endif
//
//#if canImport(SwiftUI) && DEBUG
//struct First2Preview: PreviewProvider {
//    static var previews: some View {
//        Group {
//            UIViewPreview2().frame(width: 300, height: 10)
//        }.previewLayout(.sizeThatFits)
//    }
//}
//#endif
