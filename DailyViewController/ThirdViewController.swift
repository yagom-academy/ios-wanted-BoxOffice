//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/21.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var check: UIButton!
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.idText.delegate = self
        self.passwordText.delegate = self
        self.checkPassword.delegate = self
        
        self.idText.addTarget(self, action: #selector(self.changed(_:)), for: .editingChanged)
        self.passwordText.addTarget(self, action: #selector(self.changed(_:)), for: .editingChanged)
        self.checkPassword.addTarget(self, action: #selector(self.changed(_:)), for: .editingChanged)
        
    }
    
    func isSameBothTextField(_ first: UITextField, _ second: UITextField) -> Bool {
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    }
    
    func updateButton(willActiove: Bool) {
        if(willActiove == true) {
            self.check.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            print("yes")
        } else {
            self.check.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            print("no")
        }
    }
    
    @objc func changed(_ sender: UITextField) {
    print("test :", sender.text)
        if !(self.idText.text?.isEmpty ?? true)
            && !(self.passwordText.text?.isEmpty ?? true)
            && isSameBothTextField(passwordText, checkPassword) {
            updateButton(willActiove: true)
        } else {
            updateButton(willActiove: false)
        }

    }
    
}
