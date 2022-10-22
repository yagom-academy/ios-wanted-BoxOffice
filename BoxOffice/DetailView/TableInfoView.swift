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
    let answerNumOfAudienceLabel = PaddingLabel()

    lazy var labelArr = [releaseDateLabel,filmYearLabel,playTimeLabel,genreLabel,directorLabel,actorLabel,rateLabel,numOfAudienceLabel]
    lazy var answerLabelArr = [answerReleaseDateLabel,answerFilmYearLabel,answerPlayTimeLabel,answerGenreLabel,answerDirectorLabel,answerActorLabel,answerRateLabel,answerNumOfAudienceLabel]
    
    lazy var releaseStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateLabel,answerReleaseDateLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var filmYearStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [filmYearLabel,answerFilmYearLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var playTimeStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playTimeLabel,answerPlayTimeLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var genreStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel,answerGenreLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var directorStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorLabel,answerDirectorLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var actorStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actorLabel,answerActorLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var rateStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateLabel,answerRateLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var numOfAudienceStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numOfAudienceLabel,answerNumOfAudienceLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    lazy var stackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseStack,filmYearStack,playTimeStack,genreStack,directorStack,actorStack,rateStack,numOfAudienceStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
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
        self.addSubview(stackViewV)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewV.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewV.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewV.leadingAnchor.constraint(equalTo: self.leadingAnchor)
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
        labelArr.forEach{
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .center
            $0.textColor = .secondaryLabel
            $0.backgroundColor = .secondarySystemBackground
            $0.widthAnchor.constraint(equalTo: playTimeLabel.widthAnchor).isActive = true
        }
        answerLabelArr.forEach{
            $0.backgroundColor = .secondarySystemBackground
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20)
            $0.numberOfLines = 0
        }
        
    }
    
    func enumerateContents(_ stringArr:[String]) -> String{
        if stringArr.count <= 1{
            return stringArr.first ?? ""
        }else{
            var result = stringArr.reduce(""){$0 + ", " + $1}
            result.removeFirst()
            return result
        }
    }
    
    func makeAnyArrToStringArr(_ anyArr:[Any]) -> [String]{
        if let genre = anyArr as? [Genre]{
            return genre.map{ $0.genreNm }
        }else if let peopleNm = anyArr as? [PeopleNm]{
            return peopleNm.map{ $0.peopleNm }
        }else if let watchGrade = anyArr as? [WatchGrade]{
            return watchGrade.map{ $0.watchGradeNm }
        }
        return [""]
    }
    
    func setInfo(releaseDate:String, filmYear:String, playTime:String, genre:[Genre], director:[PeopleNm], actor:[PeopleNm], rate:[WatchGrade], numOfAudience:String, upAndDonw:String){
        
        let director = enumerateContents(makeAnyArrToStringArr(director))
        let actor = enumerateContents(makeAnyArrToStringArr(actor))
        let genre = enumerateContents(makeAnyArrToStringArr(genre))
        let rate = enumerateContents(makeAnyArrToStringArr(rate))
        
        answerReleaseDateLabel.text = releaseDate
        answerFilmYearLabel.text = filmYear
        answerPlayTimeLabel.text = "\(playTime)분"
        answerGenreLabel.text = genre
        answerDirectorLabel.text = director
        answerActorLabel.text = actor
        answerRateLabel.text = rate
        answerNumOfAudienceLabel.text = numOfAudience.isOverTenThousand()
    }
}
