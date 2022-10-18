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
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "관객수"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "~~명"
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
    
    private func setupLayouts() {
        self.contentView.addSubViewsAndtranslatesFalse(self.titleLabel,
                                                       self.infoLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            self.infoLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
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
