//
//  String+Extension.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import CryptoKit

extension String {
    func asDate(format: DateFormat = .yyyyMMddHypen) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        return formatter.date(from: self)
    }
    
    func validatePassword() -> Bool {
        let passwordRegex = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$])[A-Za-z\d!@#$]{6,20}$"#
        return self.range(of: passwordRegex, options: .regularExpression) != nil
    }
    
    func sha256() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        var result = ""
        SHA256.hash(data: data).forEach { byte in
            result += String(format: "%02x", byte)
        }
        return result
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
