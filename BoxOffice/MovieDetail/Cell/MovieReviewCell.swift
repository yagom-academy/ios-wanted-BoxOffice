//
//  MovieReviewCell.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/21.
//

import UIKit

final class MovieReviewCell: UITableViewCell {
    
    static let identifier: String = "MovieReviewCell"
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.text = "닉넴"
        return label
    }()
    
    private let starScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.text = "⭐️ 4.5"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.text = "내용"
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayouts() {
        infoStackView.addArrangedSubviews(self.nicknameLabel, self.contentLabel)
        self.contentView.addSubViewsAndtranslatesFalse(infoStackView,
                                                       starScoreLabel)
        
        NSLayoutConstraint.activate([
            self.starScoreLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.starScoreLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.starScoreLabel.trailingAnchor, constant: 20),
            self.infoStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        
        ])
            
    }
    
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct UIViewPreddview2: UIViewRepresentable {
//    typealias UIViewType = MovieReviewCell
//
//    // MARK: - UIViewRepresentable
//    func makeUIView(context: Context) -> MovieReviewCell {
//        return MovieReviewCell()
//    }
//
//    func updateUIView(_ view: MovieReviewCell, context: Context) {
//
//    }
//}
//#endif
//
//#if canImport(SwiftUI) && DEBUG
//struct First2Preview: PreviewProvider {
//    static var previews: some View {
//        Group {
//            UIViewPreddview2().frame(width: 300, height: 20)
//        }.previewLayout(.sizeThatFits)
//    }
//}
//#endif
