//
//  MovieInfoCell.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import UIKit

class MovieInfoCell: UICollectionViewCell {
    static var identifier: String { String(describing: self) }

    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var prdtLabel: UILabel!
    @IBOutlet weak var showTmLabel: UILabel!
    @IBOutlet weak var watchGradeLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initailize()
    }
    
    private func initailize() {
        prepareForReuse()
    }
    
    func set(data: MovieInfoData) {
        prdtLabel.text = "제작연도: \(data.prdtYear)"
        showTmLabel.text = "상영시간: \(data.showTm)분"
        watchGradeLabel.text = data.audits.first?.watchGradeNm
        
        let genres = data.genres.compactMap { $0.genreNm }.joined(separator: ", ")
        genreLabel.text = "장르: \(genres)"
        
        let directors = data.directors.compactMap { $0.peopleNm }.joined(separator: ", ")
        directorLabel.text = "감독: \(directors)"
        
        let actors = data.actors.compactMap { $0.peopleNm }.joined(separator: ", ")
        actorLabel.text = "배우: \(actors)"
    }
    
    func getEstimatedSize(data: MovieInfoData) -> CGSize {
        set(data: data)
        
        return self.systemLayoutSizeFitting(
            CGSize(width: contentView.frame.width, height: contentView.frame.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        separatorView.layer.cornerRadius = 10
        separatorView.layer.borderWidth = 2
        separatorView.layer.borderColor = UIColor.systemGray.cgColor
        
        prdtLabel.text = ""
        showTmLabel.text = ""
        genreLabel.text = ""
        watchGradeLabel.text = ""
    }

}
