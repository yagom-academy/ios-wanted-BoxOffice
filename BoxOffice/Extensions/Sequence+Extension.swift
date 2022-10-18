//
//  Sequence+Extension.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
