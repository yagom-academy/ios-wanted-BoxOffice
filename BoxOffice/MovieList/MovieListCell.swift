//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by 김지인 on 2022/10/17.
//

import UIKit

enum RankNewStatus: String {
    case new = "NEW"
    case old = "OLD"
}

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
        label.text = RankNewStatus.new.rawValue
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
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "스파이더맨"
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
    
    private func configureUI() {
        self.contentView.layer.cornerRadius = 10 //안먹음
        self.contentView.clipsToBounds = true
        self.backgroundColor = .systemGray6
    }
    
   
    private func setupLayouts() {
        [self.boxOfficeRank, self.rankOldAndNew, self.rankInten].forEach {
            self.rankStateStackView.addArrangedSubview($0)
        }
        self.contentView.addSubViewsAndtranslatesFalse(
            self.rankStateStackView,
            self.movieTitle,
            self.openDate,
            self.audienceCount)
           
        
        NSLayoutConstraint.activate([
            //rank
            self.rankStateStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            self.rankStateStackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            //title
            self.movieTitle.topAnchor.constraint(equalTo: self.rankStateStackView.topAnchor),
            self.movieTitle.leadingAnchor.constraint(equalTo: self.rankStateStackView.leadingAnchor, constant: 80),
            self.openDate.leadingAnchor.constraint(equalTo: self.movieTitle.leadingAnchor),
            self.openDate.topAnchor.constraint(equalTo: self.movieTitle.topAnchor, constant: 30),
            self.audienceCount.leadingAnchor.constraint(equalTo: self.movieTitle.leadingAnchor),
            self.audienceCount.topAnchor.constraint(equalTo: self.openDate.topAnchor, constant: 20)
            
        ])
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
