//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by 김지인 on 2022/10/17.
//

import UIKit

final class MovieListCell: UICollectionViewCell {
    private let boxOfficeRank: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    private let rankOldAndNew: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        label.text = RankOldAndNew.new.rawValue
        return label
    }()
    
    private let rankInten: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.text = "-1"
        return label
    }()
    
    private let rankStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교"
        label.numberOfLines = 0
        return label
    }()
    
    private let openDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "2022/01/23"
        return label
    }()
    
    private let audienceCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "123214명"
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayouts()
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ data: MovieListModel) {
        self.boxOfficeRank.text = data.rank
        self.rankOldAndNew.text = data.rankOldAndNew
        self.rankInten.text = data.audienceInten
        self.movieTitle.text = data.movieName
        self.openDate.text = data.openDate
        self.audienceCount.text = data.audienceCount
    }
    
    // MARK: - private
    private func configureUI() {
        self.contentView.layer.cornerRadius = 10 //안먹음
        self.contentView.clipsToBounds = true
        self.backgroundColor = .systemGray6
    }
   
    private func setupLayouts() {
        [self.boxOfficeRank, self.rankOldAndNew, self.rankInten].forEach {
            self.rankStateStackView.addArrangedSubview($0)
        }
        [self.movieTitle, self.openDate, self.audienceCount].forEach {
            self.movieInfoStackView.addArrangedSubview($0)
        }
        self.contentView.addSubViewsAndtranslatesFalse(
            self.rankStateStackView,
            self.movieInfoStackView)
        
        NSLayoutConstraint.activate([
            //rank
            self.rankStateStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
            self.rankStateStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.movieInfoStackView.leadingAnchor.constraint(equalTo: self.rankStateStackView.trailingAnchor, constant: 30),
            self.movieInfoStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.movieInfoStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    // TODO: Dynamic height 구현중
    func fittingSize(width: CGFloat, item: MovieListModel) -> CGSize {
        let cell = MovieListCell()
        cell.configure(item)
        let targetSize = CGSize(width: width
                                , height: UIView.layoutFittingCompressedSize.height)
        return self.contentView.systemLayoutSizeFitting(targetSize,
                                                            withHorizontalFittingPriority:.fittingSizeLevel,
                                                            verticalFittingPriority:.required)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
    
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
struct FirstSectionCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = MovieListCell(frame: .zero)
            return cell
        }.previewLayout(.fixed(width: 200, height: 80))
    }
}
#endif
