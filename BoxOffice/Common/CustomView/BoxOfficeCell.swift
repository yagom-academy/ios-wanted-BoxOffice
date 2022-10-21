//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit

class BoxOfficeCell: UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var varianceImage: UIImageView!
    @IBOutlet weak var varianceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    private func initialize() {
        prepareForReuse()
    }
    
    func set(data: BoxOfficeData) {
        rankingLabel.text = data.rank
        if data.rankOldAndNew == "New" {
            varianceImage.isHidden = true
            varianceLabel.text = data.rankOldAndNew
        } else {
            varianceImage.image = UIImage()
            varianceLabel.text = data.rankInten
        }
        titleLabel.text = data.movieNm
        openingDateLabel.text = data.openDt
        attendanceLabel.text = data.audiCnt
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankingLabel.text = ""
        varianceImage.isHidden = false
        varianceImage.image = UIImage()
        varianceLabel.text = ""
        titleLabel.text = ""
        openingDateLabel.text = ""
        attendanceLabel.text = ""
    }
}
