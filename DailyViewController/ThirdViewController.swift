//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/21.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameImage: UIImageView!
    let imgPickerController = UIImagePickerController()
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var check: UIButton!
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    @IBAction func touchUpButton(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true)
    }
    
    lazy var rightNavButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "📷", style: .plain, target: self, action: #selector(add))
        return button
    }()
    @objc func add(_ sender: UIButton) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        self.present(camera, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightNavButton
        self.idText.delegate = self
        self.passwordText.delegate = self
        self.checkPassword.delegate = self
        imgPickerController.delegate = self
        
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



extension ThirdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(savedVideo), nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    @objc func savedVideo(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            print(error)
            return
        }
    }
    
    func imagePickerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePicker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage {
            self.nameImage.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
