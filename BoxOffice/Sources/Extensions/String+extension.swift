//
//  String+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit

extension String {
    
    func asDate(format: DateFormat = .yyyyMMddHypen) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
    func toUIImage() -> UIImage? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return UIImage(data: data)
    }


}

enum DateFormat: String {
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddDot = "yyyy.MM.dd"
    case yyyyMMddHypen = "yyyy-MM-dd"
}
