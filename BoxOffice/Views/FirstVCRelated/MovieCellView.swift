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
    
    //output
    
    //properties
    var posterImageView = CacheImageView() //포스터
    var presentRankLabel = UILabel() //박스오피스 순위
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
        self.addSubview(movieNameLabel)
        self.addSubview(relesedDateLabel)
        self.addSubview(watchedCustomerCountLabel)
        self.addSubview(rankIncrementLabel)
        self.addSubview(approachedRankIndexLabel)
        
        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        
        
    }
    
    func configureView() {
        posterImageView.addStyles(style: cellPosterImageViewStyling)
        presentRankLabel.addStyles(style: cellPresentRankLabelStyling)
        movieNameLabel.addStyles(style: cellMovieNameLabelStyling)
        relesedDateLabel.addStyles(style: cellRelesedDateLabelStyling)
        watchedCustomerCountLabel.addStyles(style: cellWatchedCustomerCountLabelStyling)
        rankIncrementLabel.addStyles(style: cellRankIncrementLabelStyling)
    }
    
    func bind() {
        
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
