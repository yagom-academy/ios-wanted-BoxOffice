//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit
import MessageUI

final class DetailViewController: UIViewController {
    static var identifier: String { String(describing: self) }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let vm = DetailViewModel()
    private var dto: DetailDTO?
    
    var boxOfficeData: BoxOfficeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        fetchData()
    }
    
    func setupUI() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        
        let boxOfficeNib = UINib(nibName: BoxOfficeCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(boxOfficeNib, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
        
        let movieInfoNib = UINib(nibName: MovieInfoCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(movieInfoNib, forCellWithReuseIdentifier: MovieInfoCell.identifier)
    }
    
    func fetchData() {
        Task { [weak self] in
            guard let self = self,
                  let boxOfficeData = self.boxOfficeData else { return }
            dto = try await self.vm.fetchDetailView(boxOfficeData: boxOfficeData)
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        
        let composeViewController = MFMessageComposeViewController()
        
        let data = dto?.dataSource.first?.items
        let data2 = dto?.dataSource.last?.items
        var rank = ""
        var rankInten = ""
        var rankOldAndNew = ""
        var movieNm = ""
        var openDt = ""
        var audiCnt = ""
        var movieCd = ""
        var prdtYear = ""
        var showTm = ""
        var genres = ""
        var directors = ""
        var actors = ""
        var audits = ""
        
        data?.forEach({ row in
            switch row {
            case .movieInfoWithBoxOffice(let boxOfficeData):
                rank = boxOfficeData.rank
                rankInten = boxOfficeData.rankInten
                rankOldAndNew = boxOfficeData.rankOldAndNew
                movieNm = boxOfficeData.movieNm
                openDt = boxOfficeData.openDt
                audiCnt = boxOfficeData.audiCnt
                
            default: print("")
            }
        })
        
        data2?.forEach({ row in
            switch row {
            case .movieInfo(let movieInfoData):
                movieCd = movieInfoData.movieCd
                prdtYear = movieInfoData.prdtYear
                showTm = movieInfoData.showTm
                genres = movieInfoData.genres.compactMap { $0.genreNm }.joined(separator: ", ")
                directors = movieInfoData.directors.compactMap { $0.peopleNm }.joined(separator: ", ")
                actors = movieInfoData.actors.compactMap { $0.peopleNm }.joined(separator: ", ")
                audits = movieInfoData.audits.first?.watchGradeNm ?? ""
                
            default: print("")
            }
        })
        
        composeViewController.body = """
            rank: \(rank)
            rankInten: \(rankInten)
            rankOldAndNew: \(rankOldAndNew)
            movieNm: \(movieNm)
            openDt: \(openDt)
            audiCnt: \(audiCnt)
            movieCd: \(movieCd)
            prdtYear: \(prdtYear)
            showTm: \(showTm)
            genres: \(genres)
            directors: \(directors)
            actors: \(actors)
            audits: \(audits)
        """
        
        self.present(composeViewController, animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dto?.dataSource.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dto?.dataSource[section].items.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dto?.dataSource[indexPath.section] else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            return cell
        }
        
        let row = dataSource.items[indexPath.row]
        
        switch row {
        case .movieInfoWithBoxOffice(let boxOfficeData):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath)
            if let cell = cell as? BoxOfficeCell {
                cell.set(data: boxOfficeData)
            }
            return cell
        case .movieInfo(let movieInfoData):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieInfoCell.identifier, for: indexPath)
            if let cell = cell as? MovieInfoCell {
                cell.set(data: movieInfoData)
            }
            return cell
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let dataSource = dto?.dataSource[indexPath.section] else { return .zero }
        let row = dataSource.items[indexPath.row]
        
        switch row {
        case .movieInfoWithBoxOffice(let boxOfficeData):
            let width = UIScreen.main.bounds.width - 16
            guard let boxOfficeCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath) as? BoxOfficeCell else { return .zero }
            let estimatedSize = boxOfficeCell.getEstimatedSize(data: boxOfficeData)
            return CGSize(width: width, height: estimatedSize.height)
            
        case .movieInfo(let movieInfoData):
            let width = UIScreen.main.bounds.width - 16
            guard let moviewInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieInfoCell.identifier, for: indexPath) as? MovieInfoCell else { return .zero }
            let estimatedSize = moviewInfoCell.getEstimatedSize(data: movieInfoData)
            return CGSize(width: width, height: estimatedSize.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension DetailViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled, .sent, .failed:
            self.dismiss(animated: true)
        default:
            self.dismiss(animated: true)
        }
    }
}
