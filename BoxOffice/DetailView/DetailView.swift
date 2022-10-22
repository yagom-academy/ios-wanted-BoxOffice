//
//  DetailView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

protocol DetailViewProtocol{
    func presentReviewWriteView()
}

class DetailView : UIView {
    
    let scrollView = UIScrollView()
    
    let newLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "New"
        lbl.textColor = .systemYellow
        lbl.font = .boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    let posterView : UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let rankLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        lbl.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        lbl.textAlignment = .center
        lbl.textColor = .label
        return lbl
    }()
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        lbl.textAlignment = .center
        return lbl
    }()
    
    let tableInfoView = TableInfoView()
    
    let reviewTitleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "리뷰"
        lbl.font = .preferredFont(for: .title1, weight: .heavy)
        return lbl
    }()
    let reviewPointLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .body)
        return lbl
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
        return stackView
    }()
    
    let fillView = UIView()
    
    lazy var writeButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(" 리뷰작성 ", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(presentWriteReviewView), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewTitleLabel,reviewPointLabel,starStackH,fillView,writeButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .firstBaseline
        return stackView
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    lazy var stackV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newLabel,posterView,titleLabel,tableInfoView,stackH,tableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    var reviews : [ReviewModel] = []

    var profiles : [UIImage] = []
                
    var delegate : DetailViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        tableViewConfiguration()
        scrollView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackV)
        scrollView.addSubview(newLabel)
        posterView.addSubview(rankLabel)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 3 / 2),
            stackV.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackV.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackV.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackV.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            tableInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            rankLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            rankLabel.topAnchor.constraint(equalTo: posterView.topAnchor),
            rankLabel.widthAnchor.constraint(equalTo: rankLabel.heightAnchor),
            newLabel.bottomAnchor.constraint(equalTo: posterView.topAnchor),
            newLabel.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
            reviewTitleLabel.leadingAnchor.constraint(equalTo: tableInfoView.leadingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    func tableViewConfiguration(){
        tableView.dataSource = self
        tableView.register(CustomReviewCell.self, forCellReuseIdentifier: CustomReviewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }

    func setInfo(movie:Movie){
        newLabel.isHidden = movie.boxOfficeInfo.rankOldAndNew == "NEW" ? false : true
        posterView.image = movie.poster
        titleLabel.text = movie.boxOfficeInfo.movieNm
        rankLabel.text = movie.boxOfficeInfo.rank
        tableInfoView.setInfo(releaseDate: movie.boxOfficeInfo.openDt, filmYear: movie.detailInfo.prdtYear, playTime: movie.detailInfo.showTm, genre: movie.detailInfo.genres, director: movie.detailInfo.directors, actor: movie.detailInfo.actors, rate: movie.detailInfo.audits, numOfAudience: movie.boxOfficeInfo.audiAcc,upAndDonw: movie.boxOfficeInfo.rankInten)
        if let rating = movie.rating.last?.Value{
            let stringToDouble = floor((Double(rating.extractRating()) ?? 5.0) / 10 ) / 2
            setNumOfStars(numOfStars: stringToDouble)
            reviewPointLabel.text = "\(stringToDouble)"
        }else{
            reviewPointLabel.text = "리뷰가 없습니다"
            starStackH.isHidden = true
        }
    }
    
    func setNumOfStars(numOfStars:Double){
        if numOfStars < 0{
            _ = starArr.map{$0.image = UIImage(systemName: "star")}
        }else if numOfStars > 5{
            _ = starArr.map{$0.image = UIImage(systemName: "star.fill")}
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
        }
    }
    
    @objc func presentWriteReviewView(){
        delegate?.presentReviewWriteView()
    }
}

extension DetailView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomReviewCell.id, for: indexPath) as? CustomReviewCell else { return UITableViewCell()}
        let review = reviews[indexPath.row]
        if profiles.count > indexPath.row{
            cell.profileView.image = profiles[indexPath.row]
        }
        cell.nickNameLabel.text = review.id
        cell.reviewLabel.text = review.comment
        return cell
    }
}
