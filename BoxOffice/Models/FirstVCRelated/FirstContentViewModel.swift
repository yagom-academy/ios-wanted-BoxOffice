//
//  FirstContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

class FirstContentViewModel {
    
    //input
    var didReceiveEntity: (KoficMovieEntity) -> () = { entity in }
    
    //output
    @MainThreadActor var didReceiveViewModel: ( ((Void)) -> () )?
    
    var dataSource: [FirstMovieCellModel] {
        return privateDataSource
    }
    
    //properties
    private var privateDataSource: [FirstMovieCellModel] = []
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity in
            guard let self = self else { return }
            self.populateEntity(result: entity)
            self.didReceiveViewModel?(())
        }
    }
    
    // TODO: 엔티티를 모델로 매핑
    private func populateEntity(result: KoficMovieEntity) {
        print(#function)
        privateDataSource = result.boxOfficeResult.dailyBoxOfficeList.map { dailyBoxOfficeValue -> FirstMovieCellModel in
            let cellModel = FirstMovieCellModel()
            cellModel.rnum = dailyBoxOfficeValue.rnum
            cellModel.rank = dailyBoxOfficeValue.rank
            cellModel.rankInten = dailyBoxOfficeValue.rankInten
            cellModel.rankOldAndNew = dailyBoxOfficeValue.rankOldAndNew.rawValue
            cellModel.movieCd = dailyBoxOfficeValue.movieCd
            cellModel.movieNm = dailyBoxOfficeValue.movieNm
            cellModel.openDt = dailyBoxOfficeValue.openDt
            cellModel.salesAmt = dailyBoxOfficeValue.salesAmt
            cellModel.salesShare = dailyBoxOfficeValue.salesShare
            cellModel.salesInten = dailyBoxOfficeValue.salesInten
            cellModel.salesChange = dailyBoxOfficeValue.salesChange
            cellModel.salesAcc = dailyBoxOfficeValue.salesAcc
            cellModel.audiCnt = dailyBoxOfficeValue.audiCnt
            cellModel.audiInten = dailyBoxOfficeValue.audiInten
            cellModel.audiChange = dailyBoxOfficeValue.audiChange
            cellModel.audiAcc = dailyBoxOfficeValue.audiAcc
            cellModel.scrnCnt = dailyBoxOfficeValue.scrnCnt
            cellModel.showCnt = dailyBoxOfficeValue.showCnt
            return cellModel
        }
    }
}
