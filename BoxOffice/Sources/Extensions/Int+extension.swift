//
//  Int+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/05.
//

import Foundation

extension Int {
    
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
