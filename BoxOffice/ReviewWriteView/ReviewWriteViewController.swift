//
//  ReviewWriteViewController.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/21.
//

import UIKit
import PhotosUI
import FirebaseStorage

class ReviewWriteViewController: UIViewController {
    
    let storage = Storage.storage()
    
    let reviewWriteView = ReviewWriteView()
    
    var movieTitle : String?
    
    var directoryPath : URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let documentPath : URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryPath: URL = documentPath.appendingPathComponent(movieTitle?.makeItFitToURL() ?? "movie")
        self.directoryPath = directoryPath
        do{
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false)
        }catch{
            print(error.localizedDescription)
        }
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
        if let pw = reviewWriteView.passwordTextField.text, check(pw: pw){
            let filePath = UUID().uuidString + (movieTitle?.makeItFitToURL() ?? "movie")
            FirebaseStorageManager.shared.uploadImage(image: reviewWriteView.profileView.image!, filePath: filePath)
            let id = reviewWriteView.nickNameTextField.text ?? ""
            let comment = reviewWriteView.reviewTextView.text ?? ""
            let rating = reviewWriteView.numOfStars
            FirebaseStorageManager.shared.uploadData(ReviewModel(id: id, pw: pw, comment: comment, rating: rating, profile: "imageName"), filePath: filePath)
            if let directoryPath = directoryPath{
                let path = directoryPath.appendingPathComponent(filePath)
                if let data : Data = "1".data(using: .utf8){
                    do{
                        try data.write(to: path)
                        dismiss(animated: true)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            
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
