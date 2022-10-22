//
//  ReViewViewController.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import UIKit

class ReViewViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var reviewField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    var essentialFieldList = [UITextField]()
    let datasource = [ReviewModel]()
    lazy var dataArry: [ReviewModel] = [
        .init(uesrImage: UIImage(named: "user"), nickName: "쏘롱1", review: "추천하는영화입니다.",reViewStar: "제별점은5점입니다"),
        .init(uesrImage: UIImage(named: "user"), nickName: "쏘롱2", review: "이영화는 너무 졸려요.",reViewStar: "제별점은5점입니다"),
        .init(uesrImage: UIImage(named: "user"), nickName: "쏘롱3", review: "영화 너무 재미있습니다..",reViewStar: "제별점은5점입니다"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        essentialFieldList = [idTextField,passWordTextField,checkPasswordTextField]
    }
    
    @IBAction func completeSignUp(_ sender: Any) {
        for field in essentialFieldList {
            if !isFilled(field) {
                signUpAlert(field)
                break
            }
        }
        if !validpassword(mypassword: passWordTextField.text!) {
            guard let password = passWordTextField.text, let passwordCheck = checkPasswordTextField.text, password == passwordCheck else {
                passwordAlert(title: "비밀번호가 일치하지 않습니다.")
                return
            }
            return  passwordAlert(title: "비밀번호 형식이 잘못되었습니다.\n비밀번호는 6-20 자리 이하\n소문자,숫자,특수문자(!@#$)\n각한개씩 포함되어야 합니다.")
        } else if validpassword(mypassword: passWordTextField.text!) {
            guard let password = passWordTextField.text, let passwordCheck = checkPasswordTextField.text, password == passwordCheck else {
                passwordAlert(title: "비밀번호가 일치하지 않습니다.")
                return
            }
            showInfoAlert(with: "리뷰를작성해주세요")
        }
    }
    @IBAction func cancleButton(_ sender: UIButton) {
        idTextField.text = nil
        passWordTextField.text = nil
        checkPasswordTextField.text = nil
        idTextField.isHidden = false
        passWordTextField.isHidden = false
        checkPasswordTextField.isHidden = false
        self.reviewField.isHidden = true
        self.saveButton.isHidden = true
    }
    func showInfoAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                self.idTextField.isHidden = true
                self.passWordTextField.isHidden = true
                self.checkPasswordTextField.isHidden = true
                self.reviewField.isHidden = false
                self.saveButton.isHidden = false
                self.tableView.reloadData()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func showErrorAlert(with message: String, title: String = "Error") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func signUpAlert(_ field: UITextField) {
        DispatchQueue.main.async {
            var title = ""
            switch field {
            case self.idTextField:
                title = "아이디를 입력해주세요."
            case self.passWordTextField:
                title = "비밀번호를 입력해주세요."
            case self.checkPasswordTextField:
                title = "비밀번호를 확인해주세요."
            default:
                title = "Error"
            }
            let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { (action) in
            }
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    func passwordAlert(title: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel) { (action) in
            }
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    func isFilled(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        return true
    }
    @IBAction func reviewdeleteButton(_ sender: Any) {
        reviewdelete(title: "삭제하시겠습니까?", message: "비밀번호를 입력해주세요")
    }
    func reviewdelete(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addTextField()
            if self.passWordTextField.text?.count != alert.textFields?[0].text?.count {
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {bi in
                    if self.passWordTextField.text == alert.textFields?[0].text {
                        self.dataArry.remove(at: self.dataArry.count - 1)
                        self.tableView.reloadData()
                    }
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func validpassword(mypassword : String) -> Bool {
        let passwordreg =  ("^(?=.*[A-Za-z])(?=.*[0-9]).{6,20}$")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        dataArry.append(.init(uesrImage: UIImage(named: "user"), nickName: "\(idTextField.text!)", review: "\(reviewField.text!)", reViewStar: "별점은 몇점입니다."))
        reviewField.text = nil
        tableView.reloadData()
    }
    func setView() {
        reviewField.backgroundColor = .systemPink
        reviewField.layer.cornerRadius = 15
        reviewField.alpha = 0.9
        reviewField.attributedPlaceholder = NSAttributedString(string: "리뷰를 작성해주세요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        reviewField.isHidden = true
        saveButton.isHidden = true
    }
}
extension ReViewViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
        cell.model = dataArry[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
