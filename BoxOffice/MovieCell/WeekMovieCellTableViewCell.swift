//
//  WeekMovieCellTableViewCell.swift
//  BoxOffice
//
//  Created by so on 2022/10/20.
//

import UIKit

class WeekMovieCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var 영화명: UILabel!
    @IBOutlet weak var 관객수: UILabel!
    @IBOutlet weak var 개봉일: UILabel!
    @IBOutlet weak var 전일대비순위: UILabel!
    @IBOutlet weak var 순위: UILabel!
    @IBOutlet weak var 신규진입: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func movieModel(_ model: MovieModel) {
        
        순위.text = "영화순위: \(model.순위)"
        개봉일.text = "개봉 날짜: \(model.오픈날짜)"
        신규진입.text = model.신규진입
        if 신규진입.text == "OLD"{
            신규진입.textColor = .blue
        }else {
            if 신규진입.text == "NEW" {
                신규진입.textColor = .red
            }
        }
        영화명.text = "영화명: \(model.영화제목)"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let 관객수 = numberFormatter.string(from: NSNumber(value: Int(model.관객수) ?? 0)) else {return}
        self.관객수.text = "오늘의 관객수: \(관객수) 명"
        전일대비순위.text = "전날 대비 순위: \(model.순위증감)"
    }
}
