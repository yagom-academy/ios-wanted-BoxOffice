//
//  Extensions.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

extension NSLayoutConstraint {
    func withMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem!, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
    }
}

extension String{
    func extractYear() -> Self{
        let idx = index(startIndex, offsetBy: 3)
        return String(self[...idx])
    }
    
    func makeItFitToURL() -> Self{
        guard self.count > 0 else { return self}
        var str = ""
        for char in self{
            if char == " "{
                str.append("%20")
            }else{
                str.append(String(char))
            }
        }
        print(str)
        return str
    }
    
    func extractRating() -> Self{
        let endIndex = firstIndex(of: "/")
        guard let endIndex = endIndex else { return self}
        let idx = index(before: endIndex)
        return String(self[...idx])
    }
    
    func isOverTenThousand() -> Self{
        if let num = Double(self), num >= 10000{
            var result = String(format: "%.1f", num / 10000)
            if result.last == "0"{
                result.removeLast()
                result.removeLast()
            }
            return result + "만명"
        }else{
            return self  + "명"
        }
    }
}

extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}
