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
    
    @IBOutlet weak var separatorView: UIView!
    
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
            let rankInten = Int(data.rankInten) ?? .zero
            if rankInten < 0 {
                varianceImage.image = UIImage(systemName: "chevron.down")
                varianceImage.tintColor = .systemBlue
            } else if rankInten > 0 {
                varianceImage.image = UIImage(systemName: "chevron.up")
                varianceImage.tintColor = .systemRed
            } else {
                varianceImage.image = UIImage(systemName: "equal")
                varianceImage.tintColor = .systemOrange
            }
            varianceLabel.text = "\(abs(rankInten))"
        }
        titleLabel.text = data.movieNm
        openingDateLabel.text = "개봉일: \(data.openDt)"
        attendanceLabel.text = data.audiCnt
    }
    
    func getEstimatedSize(data: BoxOfficeData) -> CGSize {
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
        
        rankingLabel.text = ""
        varianceImage.isHidden = false
        varianceImage.image = UIImage()
        varianceLabel.text = ""
        titleLabel.text = ""
        openingDateLabel.text = ""
        attendanceLabel.text = ""
    }
}
