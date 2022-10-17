//
//  ListCollectionViewCell.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
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
    
    func initialize() {
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankingLabel.text = ""
        varianceImage.image = UIImage()
        varianceLabel.text = ""
        titleLabel.text = ""
        openingDateLabel.text = ""
        attendanceLabel.text = ""
    }
}
