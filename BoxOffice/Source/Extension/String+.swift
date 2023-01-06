//
//  String+.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
