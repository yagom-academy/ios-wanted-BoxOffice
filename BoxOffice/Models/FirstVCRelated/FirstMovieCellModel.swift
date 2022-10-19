//
//  FirstMovieCellModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

class FirstMovieCellModel {
    var rnum, rank, rankInten: String
    var rankOldAndNew: String
    var movieCd, movieNm, openDt, salesAmt: String
    var salesShare, salesInten, salesChange, salesAcc: String
    var audiCnt, audiInten, audiChange, audiAcc: String
    var scrnCnt, showCnt: String
    
    init() {
        self.rnum = ""
        self.rank = ""
        self.rankInten = ""
        self.rankOldAndNew = ""
        self.movieCd = ""
        self.movieNm = ""
        self.openDt = ""
        self.salesAmt = ""
        self.salesShare = ""
        self.salesInten = ""
        self.salesChange = ""
        self.salesAcc = ""
        self.audiCnt = ""
        self.audiInten = ""
        self.audiChange = ""
        self.audiAcc = ""
        self.scrnCnt = ""
        self.showCnt = ""
    }
}
