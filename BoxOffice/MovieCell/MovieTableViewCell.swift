//
//  MovieTableViewCell.swift
//  BoxOffice
//
//  Created by so on 2022/10/17.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var increaseRanking: UILabel!
    @IBOutlet weak var newRankingLabel: UILabel!
    
    func movieModel(_ model: MovieModel) {
        rankingLabel.text = "오늘 순위: \(model.rank)"
        openingDateLabel.text = "개봉 날짜: \(model.openDt)"
        newRankingLabel.text = model.rankOldAndNew
        if newRankingLabel.text == "OLD"{
            newRankingLabel.textColor = .blue
        }else {
            if newRankingLabel.text == "NEW" {
                newRankingLabel.textColor = .red
            }
        }
        movieNameLabel.text = "영화명: \(model.movieNm)"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let audiCnt = numberFormatter.string(from: NSNumber(value: Int(model.audiCnt) ?? 0)) else {return}
        audienceLabel.text = "오늘의 관객수: \(audiCnt)명"
        if model.rankInten > "0" {
            increaseRanking.textColor = .red
            increaseRanking.text = "전날 대비 순위: \(model.rankInten)"
            let attributeString = NSMutableAttributedString(string:  increaseRanking.text ?? "")
            attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: ( increaseRanking.text! as NSString).range(of: "전날 대비 순위:"))
            increaseRanking.attributedText = attributeString
        } else if model.rankInten < "0" {
            increaseRanking.textColor = .blue
            increaseRanking.text = "전날 대비 순위: \(model.rankInten)"
            let attributeString = NSMutableAttributedString(string:  increaseRanking.text ?? "")
            attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: ( increaseRanking.text! as NSString).range(of: "전날 대비 순위:"))
            increaseRanking.attributedText = attributeString
        } else {
            increaseRanking.text = "전날 대비 순위: \(model.rankInten)"
        }
    }
}

