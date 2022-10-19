//
//  Logger+.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let ui = Logger(subsystem: subsystem, category: "UI")
}
