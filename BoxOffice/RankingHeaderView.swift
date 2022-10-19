//
//  RankingHeaderView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

class RankingHeaderView: UICollectionReusableView {
    static let nibName = "RankingHeaderView"
    static let elementKind = "ranking-header"
    
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var selectedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calenderButton.setTitle("", for: .normal)
    }
    
    func configure(with date: String) {
        selectedDate.text = date
    }
    
    static func nib() -> UINib {
        return UINib(nibName: RankingHeaderView.nibName, bundle: nil)
    }
    
}
