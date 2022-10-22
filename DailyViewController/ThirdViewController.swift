//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/21.
//

import UIKit
//import MobileCoreServices

enum VideoHelper {
    static func startMediaBrowser(
        delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
        sourceType: UIImagePickerController.SourceType
    ) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType)
        else { return }

        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
//        mediaUI.mediaTypes = [kUTTypeMovie as String]  사진x동영상만가능
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
    }
}

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameImage: UIImageView!
    let imgPickerController = UIImagePickerController()
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var check: UIButton!
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBAction func sliderChanged(_ sender: UISlider) {
        let floatValue = floor(sender.value * 10) / 10
        let intValue = Int(floor(sender.value))
        
        for index in 1...5 {
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if Float(index) <= floatValue {
                    starImage.image = UIImage(named: "star_full")
                }
                else if (Float(index) - floatValue) <= 0.5 {
                    starImage.image = UIImage(named: "star_half")
                }
                else {
                    starImage.image = UIImage(named: "star_empty")
                    
                }
            }
        }
        self.sliderLabel?.text = String(Int(floatValue))
    }
    
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
    
    lazy var firstNavButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "🎞", style: .plain, target: self, action: #selector(keepPhoto))
        return button
    }()
    
    @objc func add(_ sender: UIButton) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        self.present(camera, animated: true)
    }
    @objc private func keepPhoto() {
        let alert = UIAlertController(title: "무엇을?", message: "무엇을?", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(cancel)
        present(alert, animated: true)
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = [rightNavButton, firstNavButton]
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
        if !(self.idText.text?.isEmpty ?? true)
            && !(self.passwordText.text?.isEmpty ?? true)
            && isSameBothTextField(passwordText, checkPassword) {
            updateButton(willActiove: true)
        } else {
            updateButton(willActiove: false)
        }
        
    }
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: false)
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
        
        if let nameImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage {
            self.nameImage.image = nameImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
