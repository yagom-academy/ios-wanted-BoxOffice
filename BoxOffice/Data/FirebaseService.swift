//
//  FirebaseService.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class FirebaseService {

    static let shared = FirebaseService()

    private let database = Firestore.firestore()

    private init() { }
}
