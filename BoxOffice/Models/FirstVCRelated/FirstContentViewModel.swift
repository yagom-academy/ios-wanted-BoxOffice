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
    var didSelectItemInTableView: (_ indexPath: IndexPath) -> () = { indexPath in }
    
    //output
    @MainThreadActor var didReceiveViewModel: ( ((Void)) -> () )?
    var propergateDidSelectItem: (_ entity: DailyBoxOfficeList) -> () = { entity in }
    
    var dataSource: [FirstMovieCellModel] {
        return privateDataSource
    }
    
    //properties
    private var privateDataSource: [FirstMovieCellModel] = []
    private var entity: KoficMovieEntity?
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity in
            guard let self = self else { return }
            self.populateEntity(result: entity)
            self.didReceiveViewModel?(())
        }
        
        didSelectItemInTableView = { [weak self] indexPath in
            guard let self = self else { return }
            guard let selectedEntity = self.findAndReturnSelectedItem(indexPathRow: indexPath.row) else { return }
            self.propergateDidSelectItem(selectedEntity)
        }
    }
    
    
    
    // TODO: 엔티티를 모델로 매핑
    private func populateEntity(result: KoficMovieEntity) {
        print(#function)
        self.entity = result
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
    
    private func findAndReturnSelectedItem(indexPathRow: Int) -> DailyBoxOfficeList? {
        guard let entity = entity else { return nil }
        return entity.boxOfficeResult.dailyBoxOfficeList[indexPathRow]
    }
}
