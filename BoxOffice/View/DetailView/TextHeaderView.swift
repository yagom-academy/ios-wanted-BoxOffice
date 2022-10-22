//
//  TextHeaderView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/20.
//

import UIKit

final class TextHeaderView: UICollectionReusableView {
    static let nibName = "TextHeaderView"
    static let elementKind = "text-header"
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        sectionTitleLabel.text = nil
    }
    
    func configure(title: String) {
        sectionTitleLabel.text = title
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TextHeaderView.nibName, bundle: nil)
    }
}
