//
//  Cancellabel.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/05.
//

import Foundation
import FirebaseStorage

protocol Cancellable {
    func cancel()
    func resume()
}

extension StorageDownloadTask: Cancellable {}
