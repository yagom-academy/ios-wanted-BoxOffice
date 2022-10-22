//
//  ReviewWriteView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/21.
//

import UIKit

protocol ReviewWriteViewProtocol{
    func pickAPicture()
    func submit()
}

class ReviewWriteView : UIView{
    
    lazy var profileView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(profileTapGesture)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let editLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "편집"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 11)
        lbl.textColor = .secondarySystemBackground
        lbl.backgroundColor = .label.withAlphaComponent(0.7)
        return lbl
    }()
    
    let nickNameTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " 별명을 입력하세요 "
        tf.backgroundColor = .quaternarySystemFill
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " 암호를 입력하세요 "
        tf.backgroundColor = .quaternarySystemFill
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let starImageView1 = UIImageView()
    let starImageView2 = UIImageView()
    let starImageView3 = UIImageView()
    let starImageView4 = UIImageView()
    let starImageView5 = UIImageView()
    
    lazy var starArr = [starImageView1,starImageView2,starImageView3,starImageView4,starImageView5]
    
    lazy var starStackH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: starArr)
        _ = starArr.map{
            $0.image = UIImage(systemName: "star.fill")
            $0.tintColor = .systemYellow
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.addGestureRecognizer(panGesture)
        return stackView
    }()
    
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag))
    
    let placeholder = "리뷰 내용을 입력하세요"
    
    lazy var reviewTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = placeholder
        tv.textColor = .systemGray2
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tv.delegate = self
        tv.font = .preferredFont(forTextStyle: .body)
        tv.adjustsFontForContentSizeCategory = true
        return tv
    }()
    
    lazy var submitButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(" 등록 ", for: .normal)
      //  btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.adjustsFontForContentSizeCategory = true
      //  btn.titleLabel?.text = " 등록 "
        btn.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return btn
    }()
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignKeyboard))
    
    lazy var profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(pickPicture))
    
    var numOfStars = 5.0
    
    var delegate : ReviewWriteViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        makeProfileViewCircle()
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(profileView)
        self.addSubview(nickNameTextField)
        self.addSubview(starStackH)
        self.addSubview(reviewTextView)
        self.addSubview(submitButton)
        self.addSubview(passwordTextField)
        profileView.addSubview(editLabel)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            profileView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            profileView.heightAnchor.constraint(equalTo:  profileView.widthAnchor),
            editLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            editLabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            editLabel.widthAnchor.constraint(equalTo: profileView.widthAnchor),
            nickNameTextField.leadingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: 10),
            nickNameTextField.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 2),
            passwordTextField.leadingAnchor.constraint(equalTo:  profileView.trailingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            passwordTextField.bottomAnchor.constraint(equalTo: starStackH.topAnchor, constant: -2),
            starStackH.leadingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: 10),
            starStackH.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 5),
            reviewTextView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            reviewTextView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 20),
            reviewTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            reviewTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func resignKeyboard(){
        self.endEditing(true)
    }
    
    @objc func submit(){
        delegate?.submit()
    }
    
    @objc func pickPicture(){
        delegate?.pickAPicture()
    }
 
    @objc func drag(_ sender:UIPanGestureRecognizer){
        let a = sender.location(in: starStackH)
        ratingStarGesture(xLocation: a.x)
    }
    
    func makeProfileViewCircle(){
        let width = UIScreen.main.bounds.width * 0.15
        profileView.layer.cornerRadius = width / 2
    }
    
    func ratingStarGesture(xLocation:CGFloat){
        let wholeWidthOfStars = starStackH.frame.width
        let xPoint = xLocation / wholeWidthOfStars * 100
        let numOfStars = floor(xPoint / 10) / 2
        setNumOfStars(numOfStars: numOfStars)
    }
    
    func setNumOfStars(numOfStars:CGFloat){
        if numOfStars < 0{
            _ = starArr.map{$0.image = UIImage(systemName: "star")}
            self.numOfStars = 0.0
        }else if numOfStars > 5{
            _ = starArr.map{$0.image = UIImage(systemName: "star.fill")}
            self.numOfStars = 5.0
        }else{
            var numOfFullStars = floor(numOfStars / 1)
            var numOfHalfStars = numOfStars.truncatingRemainder(dividingBy: 1) == 0.5 ? 1 : 0
            for star in starArr{
                if numOfFullStars > 0{
                    star.image = UIImage(systemName: "star.fill")
                    numOfFullStars -= 1
                }else if numOfHalfStars > 0{
                    star.image = UIImage(systemName: "star.leadinghalf.filled")
                    numOfHalfStars -= 1
                }else{
                    star.image = UIImage(systemName: "star")
                }
            }
            self.numOfStars = numOfStars
        }
    }
    
}

extension ReviewWriteView : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reviewTextView.text == placeholder{
            reviewTextView.text = ""
            reviewTextView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            reviewTextView.text = placeholder
            reviewTextView.textColor = .systemGray2
        }
    }
}
