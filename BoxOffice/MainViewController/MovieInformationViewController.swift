//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by so on 2022/10/18.
//

import UIKit

class MovieInformationViewController: UIViewController {
    @IBOutlet weak var 영화순위: UILabel!
    @IBOutlet weak var 영화명: UILabel!
    @IBOutlet weak var 개봉일: UILabel!
    @IBOutlet weak var 관객수: UILabel!
    @IBOutlet weak var 전일대비: UILabel!
    @IBOutlet weak var 랭킹신규진입: UILabel!
    @IBOutlet weak var 제작연도: UILabel!
    @IBOutlet weak var 감독명: UILabel!
    @IBOutlet weak var 배우명: UILabel!
    @IBOutlet weak var 상영시간: UILabel!
    @IBOutlet weak var 장르: UILabel!
    @IBOutlet weak var 관람등급: UILabel!
    @IBOutlet weak var 개봉연도: UILabel!
    
    var movieCd = ""
    
    var response : [InfomationCodable] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
      
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
