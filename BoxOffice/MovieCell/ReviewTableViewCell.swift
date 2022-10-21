//
//  ReviewTableViewCell.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var uesrImage: UIImageView!
    @IBOutlet weak var nicName: UILabel!
    @IBOutlet weak var reviewlabel: UILabel!
    @IBOutlet weak var reViewView: UIView!
    
    var model: ReviewModel? {
        didSet {
            uesrImage.image = model?.이미지
            nicName.text = model?.닉네임
            reviewlabel.text = model?.리뷰
            reViewView.backgroundColor = .systemGray5
            reViewView.alpha = 0.8
            reViewView.layer.cornerRadius = 15
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
