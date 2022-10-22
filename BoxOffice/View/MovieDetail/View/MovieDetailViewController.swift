//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/19.
//

// FIXME: 코드가 너무 지저분함 수정 필요.

import UIKit
import SwiftUI

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var rootScrollView: UIScrollView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var productYearLabel: UILabel!
    @IBOutlet weak var rankDifImage: UIImageView!
    @IBOutlet weak var rankDifLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var audienceAccLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var isNewLabel: UILabel!
    @IBOutlet weak var watchGradeLabel: UILabel!
    @IBOutlet weak var showTimeMinuteLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var reviewScoreLabel: UILabel!
    @IBOutlet weak var openYearLabel: UILabel!
    @IBOutlet weak var unFoldSummaryButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var reviewStar: UIImageView!
    
    var hostingController: UIHostingController<CommentListView>?
    
    var isFoldedSummaryLabel: Bool = true
    var movieInfo: MovieInfoModel?
    var movieCd: String?
    var boxOffice: BoxOfficeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
        setLoadingCover()
        getMovieIfo()
    }
    
    func getMovieIfo() {
        RequestManager.shared.getMovieInfo(movieCd: self.movieCd!) { [weak self] movieInfo in
            guard let self = self else { return }

            self.movieInfo = movieInfo
            self.movieInfo?.dailyBoxOfficeInfo = self.boxOffice

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.setupView()
                self.unsetLoadingCover()
            }
        }
    }
    
    func getDummy() {
        // MARK: TEST dummy data 박스오피스 순위
        Dummy().getMovieInfo { [weak self] dummy in
            guard let self = self else { return }
            self.movieInfo = dummy
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.setupView()
                self.unsetLoadingCover()
            }
        }
    }
    
    @IBAction func showAllCommentListView(_ sender: Any) {
        let vc = UIHostingController(rootView: CommentListView(commentManager: CommentManager.shared))
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showCommentWriteView(_ sender: Any) {
        let vc = UIHostingController(rootView: CommentWriteView(commentManager: CommentManager.shared))
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBSegueAction func loadCommentListView(_ coder: NSCoder) -> UIViewController? {
        hostingController = UIHostingController(coder: coder, rootView: CommentListView(commentManager: CommentManager.shared))
        hostingController!.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }
    
    @IBAction func unFoldSummaryButtonPressed(_ sender: UIButton) {
        let imageName = isFoldedSummaryLabel ? "chevron.up" : "chevron.down"
        let priority: Float = isFoldedSummaryLabel ? 250 : 1000
        summaryLabelHeightConstraint.priority = UILayoutPriority(priority)
        unFoldSummaryButton.setImage(UIImage(systemName: imageName), for: .normal)
        isFoldedSummaryLabel = !isFoldedSummaryLabel
    }
}

extension MovieDetailViewController: DefaultViewSetupProtocol {
    
    func setConstraints() {
    }
    
    func setupView() {
        
        movieTitleLabel.text = movieInfo?.movieNm
        reviewScoreLabel.text = "0"
        showTimeMinuteLabel.text = "\(movieInfo!.showTm)분"
        watchGradeLabel.text = movieInfo?.audits[0].watchGradeNm
        productYearLabel.text = movieInfo?.prdtYear
    
        var joinedGenres = ""
        for (i, genres) in movieInfo!.genres.enumerated() {
            joinedGenres += genres.genreNm
            joinedGenres += i != movieInfo!.genres.endIndex-1 ? ", " : ""
        }
        genresLabel.text = joinedGenres
        
        var joinedDirectors = ""
        for (i, director) in movieInfo!.directors.enumerated() {
            joinedDirectors += director.peopleNm
            joinedDirectors += i != movieInfo!.directors.endIndex-1 ? ", " : ""
        }
        directorLabel.text = joinedDirectors
        
        var joinedActors = ""
        for (i, actor) in movieInfo!.actors.enumerated() {
            joinedActors += actor.peopleNm
            joinedActors += i != movieInfo!.actors.endIndex-1 ? ", " : ""
        }
        actorLabel.text = joinedActors == "" ? "-" : joinedActors
        
        let daily = movieInfo?.dailyBoxOfficeInfo
        var image = UIImage()
        var color = UIColor()
        switch Int(daily!.rankInten)! {
        case 1...:
            let config = UIImage.SymbolConfiguration(pointSize: 15)
            image = UIImage(systemName: "arrowtriangle.up.fill", withConfiguration: config)!
            color = UIColor(red: 255/255, green: 89/255, blue: 48/255, alpha: 1.0)
            break
        case ..<0:
            let config = UIImage.SymbolConfiguration(pointSize: 15)
            image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: config)!
            color = UIColor(red: 102/255, green: 199/255, blue: 89/255, alpha: 1.0)
            break
        case 0:
            let config = UIImage.SymbolConfiguration(pointSize: 15)
            image = UIImage(systemName: "minus", withConfiguration: config)!
            color = .systemGray
            rankDifLabel.alpha = 0
            break
        default:
            break
        }
        rankDifImage.image = image
        rankDifImage.image = rankDifImage.image?.withTintColor(color, renderingMode: .alwaysOriginal)
        
        openDateLabel.text = daily?.openDt.replacingOccurrences(of: "-", with: ".")
        openYearLabel.text = daily?.openDt.split(separator: "-")[0].description
        isNewLabel.alpha = daily!.rankOldAndNew == "NEW" ? 1 : 0
        audienceAccLabel.text = "\(changeToDecimal(daily!.audiAcc)!)명"
        rankLabel.text = "박스오피스 \(daily!.rank)위"
        rankDifLabel.text = abs(Int(daily!.rankInten)!).description
        summaryLabel.text = "준비중"
    }
    
    @objc func shareMovieInfo() {
        var objectsToShare = [String]()
        
        let msg = "\(movieTitleLabel.text!.description) \n\n" +
        "리뷰점수 \(reviewScoreLabel.text!.description)점 \(openYearLabel.text!.description) \(showTimeMinuteLabel.text!.description) \(watchGradeLabel.text!.description) \(movieInfo?.dailyBoxOfficeInfo?.rankOldAndNew == "NEW" ? "NEW" : "") \n\n" +
        "● \(rankLabel.text!) 순위변동 \(movieInfo!.dailyBoxOfficeInfo!.rankInten) \n" +
        "● 장르 \(genresLabel.text!.description) \n" +
        "● 감독 \(directorLabel.text!.description) \n" +
        "● 주연 \(actorLabel.text!.description) \n" +
        "● 개봉 \(openDateLabel.text!.description) \n" +
        "● 제작연도 \(productYearLabel.text!.description) \n" +
        "● 누적관객 \(audienceAccLabel.text!.description) \n\n" +
        "● 줄거리 \n\n" +
        "\(summaryLabel.text!.description)"
        
        objectsToShare.append(msg)
//        objectsToShare.append(self.view.transfromToImage()!)
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.saveToCameraRoll]
        activityVC.popoverPresentationController?.sourceView = self.view
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
//        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func configureView() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareMovieInfo))
        self.navigationItem.rightBarButtonItem = shareButton
        rootScrollView.decelerationRate = .fast
    }
}

extension MovieDetailViewController {
    
    func changeDateStringFormat(_ string: String) -> String {
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy-MM-dd"
        toDateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        let date = toDateFormatter.date(from: string)
        let toStringFormatter = DateFormatter()
        toStringFormatter.dateFormat = "yy.MM.dd"
        let result = toStringFormatter.string(from: date!)
        return result
    }
    
    func changeToDecimal(_ string: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: UInt(string)!))
        guard let result = result else {
            return "-"
        }
        return result
    }
}


public class VerticalAlignLabel: UILabel {
    enum VerticalAlignment {
        case top
        case middle
        case bottom
    }

    var verticalAlignment : VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)

        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            switch verticalAlignment {
            case .top:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            switch verticalAlignment {
            case .top:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }

    override public func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }
}

extension MovieDetailViewController {
    func setLoadingCover() {
        rankLabel.text = "박스오피스 0위"
        rankDifLabel.text = "0"
        isNewLabel.alpha = 0
        self.movieTitleLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.movieTitleLabel.textColor = UIColor(named: "coverColorAsset")
        self.genresLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.genresLabel.textColor = UIColor(named: "coverColorAsset")
        self.directorLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.directorLabel.textColor = UIColor(named: "coverColorAsset")
        self.actorLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.actorLabel.textColor = UIColor(named: "coverColorAsset")
        self.openDateLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.openDateLabel.textColor = UIColor(named: "coverColorAsset")
        self.productYearLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.productYearLabel.textColor = UIColor(named: "coverColorAsset")
        self.audienceAccLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.audienceAccLabel.textColor = UIColor(named: "coverColorAsset")
        self.summaryLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.summaryLabel.textColor = UIColor(named: "coverColorAsset")
        self.reviewScoreLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.reviewScoreLabel.textColor = UIColor(named: "coverColorAsset")
        self.openYearLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.openYearLabel.textColor = UIColor(named: "coverColorAsset")
        self.showTimeMinuteLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.showTimeMinuteLabel.textColor = UIColor(named: "coverColorAsset")
        self.watchGradeLabel.backgroundColor = UIColor(named: "coverColorAsset")
        self.watchGradeLabel.textColor = UIColor(named: "coverColorAsset")
        self.reviewStar.tintColor = UIColor(named: "coverColorAsset")
    }
    
    func unsetLoadingCover() {
        self.movieTitleLabel.backgroundColor = .clear
        self.movieTitleLabel.textColor = UIColor(named: "foregroundColorAsset")
        self.genresLabel.backgroundColor = .clear
        self.genresLabel.textColor = UIColor(named: "subTextColorAsset")
        self.directorLabel.backgroundColor = .clear
        self.directorLabel.textColor = UIColor(named: "subTextColorAsset")
        self.actorLabel.backgroundColor = .clear
        self.actorLabel.textColor = UIColor(named: "subTextColorAsset")
        self.openDateLabel.backgroundColor = .clear
        self.openDateLabel.textColor = UIColor(named: "subTextColorAsset")
        self.productYearLabel.backgroundColor = .clear
        self.productYearLabel.textColor = UIColor(named: "subTextColorAsset")
        self.audienceAccLabel.backgroundColor = .clear
        self.audienceAccLabel.textColor = UIColor(named: "subTextColorAsset")
        self.summaryLabel.backgroundColor = .clear
        self.summaryLabel.textColor = UIColor(named: "subTextColorAsset")
        self.reviewScoreLabel.backgroundColor = .clear
        self.reviewScoreLabel.textColor = UIColor(named: "foregroundColorAsset")
        self.openYearLabel.backgroundColor = .clear
        self.openYearLabel.textColor = UIColor(named: "foregroundColorAsset")
        self.showTimeMinuteLabel.backgroundColor = .clear
        self.showTimeMinuteLabel.textColor = UIColor(named: "foregroundColorAsset")
        self.watchGradeLabel.backgroundColor = .clear
        self.watchGradeLabel.textColor = UIColor(named: "foregroundColorAsset")
        self.reviewStar.tintColor = UIColor(red: 255/255, green: 89/255, blue: 48/255, alpha: 1.0)
    }
}

// MARK: Share 기능 사용시 View를 Image로 바꾸고싶을때
extension UIView {
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
