//
//  TableInfoView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class TableInfoView : UIView {
    
    let releaseDateLabel = PaddingLabel()
    let filmYearLabel = PaddingLabel()
    let playTimeLabel = PaddingLabel()
    let genreLabel = PaddingLabel()
    let directorLabel = PaddingLabel()
    let actorLabel = PaddingLabel()
    let rateLabel = PaddingLabel()
    let numOfAudienceLabel = PaddingLabel()
    let answerReleaseDateLabel = PaddingLabel()
    let answerFilmYearLabel = PaddingLabel()
    let answerPlayTimeLabel = PaddingLabel()
    let answerGenreLabel = PaddingLabel()
    let answerDirectorLabel = PaddingLabel()
    let answerActorLabel = PaddingLabel()
    let answerRateLabel = PaddingLabel()
    let answerBumOfAudienceLabel = PaddingLabel()
    
    lazy var labelArr = [releaseDateLabel,filmYearLabel,playTimeLabel,genreLabel,directorLabel,actorLabel,rateLabel,numOfAudienceLabel]
    lazy var answerLabelArr = [answerReleaseDateLabel,answerFilmYearLabel,answerPlayTimeLabel,answerGenreLabel,answerDirectorLabel,answerActorLabel,answerRateLabel,answerBumOfAudienceLabel]
    
    lazy var stackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: labelArr)
        stackView.distribution = .fill
       // stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    lazy var answerStackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: answerLabelArr)
        stackView.distribution = .fill
        //stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    lazy var stackViewH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewV,answerStackViewV])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
   //     stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 2
      //  stackView.backgroundColor = .secondarySystemBackground
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        setLables()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(stackViewH)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewH.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewH.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewH.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewH.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    func setLables(){
        releaseDateLabel.text = "개봉일"
        filmYearLabel.text = "제작년도"
        playTimeLabel.text = "상영시간"
        genreLabel.text = "장르"
        directorLabel.text = "감독명"
        actorLabel.text = "배우명"
        rateLabel.text = "관람등급"
        numOfAudienceLabel.text = "관객수"
        _ = (labelArr + answerLabelArr).map{
            $0.backgroundColor = .secondarySystemBackground
            $0.widthAnchor.constraint(equalTo: stackViewV.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20)
            //$0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor =  10 / $0.font.pointSize
            //$0.lineBreakMode = .byCharWrapping //마지막 글자까지 다 쓰고 넘어가기
        }
    }
    
    func setInfo(releaseDate:String, filmYear:String, playTime:String, genre:String, director:String, actor:[PeopleNm], rate:String, numOfAudience:String){
        
        let actor = actor.count > 0 ?  actor[0].peopleNm : "없음"
        
        answerReleaseDateLabel.text = releaseDate
        answerFilmYearLabel.text = filmYear
        answerPlayTimeLabel.text = "\(playTime)분"
        answerGenreLabel.text = genre
        answerDirectorLabel.text = director
        answerActorLabel.text = actor
        answerRateLabel.text = rate
        answerBumOfAudienceLabel.text = "\(numOfAudience)명"
    }
}
