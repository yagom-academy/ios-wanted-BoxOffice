//
//  String+Extension.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/03.
//

import UIKit

extension String {
    var toUIImage: UIImage? {
        get {
            guard let data = Data(base64Encoded: self) else {
                return nil
            }
            return UIImage(data: data)
        }
    }
}
