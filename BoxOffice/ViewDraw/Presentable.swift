//
//  Presentable.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

//모든 뷰컨트롤러가 따라야 할 프로토콜
//loadView에서 처리한다
protocol Presentable {
    func initViewHierarchy() //addsubview, autolayout
    func configureView() //viewColor, font, etc
    func bind() //bind to Model, ViewModel
}
