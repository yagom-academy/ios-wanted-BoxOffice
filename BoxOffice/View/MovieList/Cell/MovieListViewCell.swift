//
//  MovieListViewCell.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/18.
//

import UIKit
import Foundation

class MovieListViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankDifferMark: UIButton!
    @IBOutlet weak var rankDifferLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOpenDateLabel: UILabel!
    @IBOutlet weak var movieAudienceCountLabel: UILabel!
    @IBOutlet weak var newMovieMark: UILabel!
//    @IBOutlet weak var rankDifferMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(viewModel: BoxOfficeModel) {
        initCell()
        rankLabel.text = viewModel.rank
        rankDifferLabel.text = abs(Int(viewModel.rankInten)!).description
        movieTitleLabel.text = viewModel.movieNm
        movieOpenDateLabel.text = "개봉 \(changeDateStringFormat(viewModel.openDt))"
        movieAudienceCountLabel.text = "\(changeToDecimal(viewModel.audiCnt)!)명"
        newMovieMark.alpha = viewModel.rankOldAndNew == "NEW" ? 1 : 0
        
        var image = UIImage()
        var color = UIColor()
        switch Int(viewModel.rankInten)! {
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
            rankDifferLabel.alpha = 0
            break
        default:
            break
        }
        rankDifferMark.setImage(image, for: .normal)
        rankDifferMark.tintColor = color
//        rankDifferMark.image = image
//        rankDifferMark.image = rankDifferMark.image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    func initCell() {
        newMovieMark.alpha = 0
        rankDifferLabel.alpha = 1
        rankDifferMark.alpha = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
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

class LoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func start() {
        activityIndicatorView.startAnimating()
    }
}
