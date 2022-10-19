//
//  MovieCellView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import UIKit
import SwiftUI

class MovieCellView: UIView, FirstViewStyling {

    //input
    var didReceiveViewModel: (FirstMovieCellModel) -> () = { model in }
    
    //output
    
    //properties
    var posterImageView = CacheImageView() //포스터
    var presentRankLabel = UILabel() //박스오피스 순위
    
    var verticalStackView = UIStackView()
    var movieNameLabel = UILabel() //영화명
    var relesedDateLabel = UILabel() //개봉일
    var watchedCustomerCountLabel = UILabel() //관객수
    var rankIncrementLabel = UILabel() //전일대비 순위의 증감분
    var approachedRankIndexLabel = UILabel() //랭킹에 신규 진입 여부
    
    // TODO: viewmodel
    
    init() {
        
        super.init(frame: .zero)
        initViewHierarchy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieCellView: Presentable {
    func initViewHierarchy() {
        self.addSubview(posterImageView)
        self.addSubview(presentRankLabel)
        
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(movieNameLabel)
        verticalStackView.addArrangedSubview(relesedDateLabel)
        verticalStackView.addArrangedSubview(watchedCustomerCountLabel)
        verticalStackView.addArrangedSubview(rankIncrementLabel)
        verticalStackView.addArrangedSubview(approachedRankIndexLabel)
        
        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        verticalStackView.arrangedSubviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.8)
        ]
        
        constraint += [
            presentRankLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            presentRankLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            presentRankLabel.widthAnchor.constraint(equalToConstant: 16)
        ]
        
        constraint += [
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: presentRankLabel.trailingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ]
        
        
        
        
    }
    
    func configureView() {
        
        verticalStackView.addStyles(style: cellVerticalStackViewStyling)
        
        posterImageView.addStyles(style: cellPosterImageViewStyling)
        presentRankLabel.addStyles(style: cellPresentRankLabelStyling)
        movieNameLabel.addStyles(style: cellMovieNameLabelStyling)
        relesedDateLabel.addStyles(style: cellRelesedDateLabelStyling)
        watchedCustomerCountLabel.addStyles(style: cellWatchedCustomerCountLabelStyling)
        rankIncrementLabel.addStyles(style: cellRankIncrementLabelStyling)
    }
    
    func bind() {
        didReceiveViewModel = { [weak self] model in
            guard let self = self else { return }
            // TODO: 밸류들 정확한 의미 다시 확인...좀 헷갈리기 시작함
            self.presentRankLabel.text = model.rank
            self.movieNameLabel.text = model.movieNm
            self.relesedDateLabel.text = model.openDt
            self.watchedCustomerCountLabel.text = model.showCnt
            self.rankIncrementLabel.text = model.scrnCnt
        }
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
struct MovieCellViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        self.view = builder()
    }
    
    func makeUIView(context: Context) -> some UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

#endif

#if canImport(SwiftUI) && DEBUG
struct MovieCellViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        MovieCellViewPreview {
            let view = MovieCellView()
            return view
        }.previewLayout(.fixed(width: 390, height: 100))
    }
}


#endif
