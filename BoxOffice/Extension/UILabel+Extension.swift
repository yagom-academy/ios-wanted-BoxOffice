//
//  UILabel+Extension.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/06.
//

import UIKit

extension UILabel {
    func setStarLabel(_ string: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")
        let attachmentString = NSAttributedString(attachment: attachment)
        let contentString = NSMutableAttributedString(string: string)
        contentString.insert(attachmentString, at: 0)
        self.attributedText = contentString
    }
}
