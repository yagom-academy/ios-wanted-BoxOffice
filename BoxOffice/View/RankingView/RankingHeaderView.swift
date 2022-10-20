//
//  RankingHeaderView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/19.
//

import UIKit

final class RankingHeaderView: UICollectionReusableView {
    static let nibName = "RankingHeaderView"
    static let elementKind = "ranking-header"
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calendarButton.setTitle("", for: .normal)
    }
    
    func configure(with date: String) {
        selectedDate.text = date
    }
    
    static func nib() -> UINib {
        return UINib(nibName: RankingHeaderView.nibName, bundle: nil)
    }
    
    @IBAction func didTapCalendarButton(_ sender: UIButton) {
        print("Calendar button tapped!")
    }
    
}
