//
//  String+Extension.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation

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
}
