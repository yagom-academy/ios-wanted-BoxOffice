//
//  SendDataDelegate.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/06.
//

protocol SendDataDelegate: AnyObject {
    func sendData<T>(
        _ data: T
    )
}
