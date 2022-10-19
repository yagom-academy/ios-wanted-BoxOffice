//
//  Reusable+.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import UIKit

protocol Reusable {

    static var reuseIdentifier: String { get }

}

extension Reusable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Reusable { }
extension UICollectionReusableView: Reusable { }
