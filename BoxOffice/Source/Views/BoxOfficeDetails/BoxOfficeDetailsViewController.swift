//
//  BoxOfficeDetailsViewController.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/19.
//

import UIKit

class BoxOfficeDetailsViewController: UIViewController {

    var boxOfficeDataList = [DailyBoxOfficeList]()
    var movieDetailDataList = [MovieInfo]()
    var boxOfficeHelper = BoxOfficeHelper()
    var index: Int?
    var actorArr = ""
    
    let boxOfficeDetailsView: BoxOfficeDetailsView = {
        let view = BoxOfficeDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        addSubView()
        configure()
    }

    func setupLabels() {
        let data = boxOfficeDataList[index ?? 0]
        let detailData = movieDetailDataList[index ?? 0]
        boxOfficeDetailsView.auditsImageView.image = UIImage(named: "\(boxOfficeHelper.auditsImage(detailData.audits[0].watchGradeNm))")
        boxOfficeDetailsView.movieName.text = detailData.movieNm
        boxOfficeDetailsView.movieNameEn.text = detailData.movieNmEn
        boxOfficeDetailsView.genres.text = "\(detailData.genres[0].genreNm) | "
        boxOfficeDetailsView.openDate.text = "\(data.openDt) 개봉 | "
        boxOfficeDetailsView.showTime.text = "\(detailData.showTm)분"
        boxOfficeDetailsView.prdtYear.text = "\(detailData.prdtYear)년 제작"
        boxOfficeDetailsView.boxOfficeRank.text = "\(data.rank)(\(data.rankOldAndNew))"
        boxOfficeDetailsView.rankInten.text = boxOfficeHelper.rankIntenCal(data.rankInten)
        boxOfficeDetailsView.audiAcc.text = boxOfficeHelper.audiAccCal(data.audiAcc)
        boxOfficeDetailsView.directorName.text = detailData.directors[0].peopleNm
        boxOfficeDetailsView.actorName.text = boxOfficeHelper.actorNameHelper(detailData.actors)
    }
    
    func addSubView() {
        view.addSubview(boxOfficeDetailsView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            boxOfficeDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boxOfficeDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
