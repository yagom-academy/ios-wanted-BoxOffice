//
//  InputAlert.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/21.
//

import UIKit

class InputAlert: UIAlertController {
    
    var buttonAction: ((String)->()) = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTextField { textField in
            textField.isSecureTextEntry = true
        }
        self.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.buttonAction(self.textFields?.first?.text ?? "")
        }))
        self.addAction(UIAlertAction(title: "취소", style: .cancel))
    }
}
