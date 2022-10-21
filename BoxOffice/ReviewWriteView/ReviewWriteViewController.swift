//
//  ReviewWriteViewController.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/21.
//

import UIKit
import PhotosUI

class ReviewWriteViewController: UIViewController {
    
    let reviewWriteView = ReviewWriteView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        addSubViews()
        setConstraints()
        reviewWriteView.delegate = self
    }

    func addSubViews(){
        view.addSubview(reviewWriteView)
        reviewWriteView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            reviewWriteView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            reviewWriteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            reviewWriteView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            reviewWriteView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func check(pw:String) -> Bool{
        guard 6...20 ~= pw.count else { return false}
        let capitals = (UInt8(ascii: "A")...UInt8(ascii: "Z")).reduce(""){$0 + String(Character(UnicodeScalar($1)))}
        var capitalOk = false
        let smallCase = (UInt8(ascii: "a")...UInt8(ascii: "z")).reduce(""){$0 + String(Character(UnicodeScalar($1)))}
        var smallCaseOk = false
        let numbers = (UInt8(ascii: "0")...UInt8(ascii: "9")).reduce(""){$0 + String(Character(UnicodeScalar($1)))}
        var numbersOk = false
        let special = "!@#$"
        var specialOk = false
        let testCase = capitals + smallCase + numbers + special
        for char in pw{
            if !capitalOk{
                if capitals.contains(char){
                    capitalOk = true
                }
            }
            if !smallCaseOk{
                if smallCase.contains(char){
                    smallCaseOk = true
                }
            }
            if !numbersOk{
                if numbers.contains(char){
                    numbersOk = true
                }
            }
            if !specialOk{
                if special.contains(char){
                    specialOk = true
                }
            }
            if capitalOk && smallCaseOk && numbersOk && specialOk{
                return true
            }
        }
        return false
    }

}

extension ReviewWriteViewController : ReviewWriteViewProtocol{
    func submit() {
        if let pw = reviewWriteView.passwordTextField.text{
            print(check(pw: pw))
        }
    }
    
    func pickAPicture() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

extension ReviewWriteViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.reviewWriteView.profileView.image = image as? UIImage
                    self.reviewWriteView.editLabel.isHidden = true
                }
            }
        }
    }
}
