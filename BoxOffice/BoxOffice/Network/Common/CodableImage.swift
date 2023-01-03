//
//  CodableImage.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import UIKit.UIImage

struct CodableImage: Codable {
    let image: UIImage?

    init(image: UIImage) {
        self.image = image
    }

    enum CodingKeys: CodingKey {
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        self.image = UIImage(data: data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = self.image {
            try container.encode(image.jpegData(compressionQuality: 1.0), forKey: .data)
        }
    }
}
