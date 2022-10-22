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
    @MainThreadActor var turnOnIndicator: ( ((Void)) -> () )?
    @MainThreadActor var turnOffIndicator: ( ((Void)) -> () )?
    var propergateDidSelectItem: (_ entity: DailyBoxOfficeList) -> () = { entity in }
    
    var dataSource: [FirstMovieCellModel] {
        return privateDataSource
    }
    
    //properties
    var repository: RepositoryProtocol
    private var privateDataSource: [FirstMovieCellModel] = []
    private var entity: KoficMovieEntity?
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity in
            guard let self = self else { return }
            
            Task {
                await self.populateEntity(result: entity)
                self.didReceiveViewModel?(())
                self.turnOffIndicator?(())
            }
        }
        
        didSelectItemInTableView = { [weak self] indexPath in
            guard let self = self else { return }
            guard let selectedEntity = self.findAndReturnSelectedItem(indexPathRow: indexPath.row) else { return }
            self.propergateDidSelectItem(selectedEntity)
        }
    }
    
    private func populateEntity(result: KoficMovieEntity) async {
        print(#function)
        self.entity = result
        print(">>>>")
        let timer = ParkBenchTimer()
        var closures: [() -> Task<String, Error>] = []
        for value in result.boxOfficeResult.dailyBoxOfficeList {
            async let closure: () -> Task<String, Error> = { () -> Task<String, Error> in
               Task { () -> (String) in
                    let detailed: KoficMovieDetailEntity = try await self.repository.fetch(api: .kofic(.detailMovieInfo(movieCd: value.movieCd)))
                    let posterUrl: OmdbEntity = try await self.repository.fetch(api: .omdb(movieName: detailed.movieInfoResult.movieInfo.movieNmEn, releasedYear: detailed.movieInfoResult.movieInfo.openDt.koficDateToYear() ?? "2022"))
                    return posterUrl.poster
                }
            }
            await closures.append(closure)
        }
        
        let mappedClosure = closures.map { value in
            value()
        }

        let asyncMapped = await mappedClosure.asyncMap { task in
            do {
                let result = try await task.result.get()
                return result
            } catch {
                return ""
            }
        }
        
        privateDataSource = await result.boxOfficeResult.dailyBoxOfficeList.enumerated().asyncMap { (index, dailyBoxOfficeValue) -> FirstMovieCellModel in
            let cellModel = FirstMovieCellModel()
            cellModel.rnum = dailyBoxOfficeValue.rnum
            cellModel.rank = dailyBoxOfficeValue.rank
            cellModel.rankInten = String.emojiAndTitle(emojiValue: .rankIncrement) + " " + dailyBoxOfficeValue.rankInten
            cellModel.rankOldAndNew = String.emojiAndTitle(emojiValue: .rankApproach) + " " + dailyBoxOfficeValue.rankOldAndNew.rawValue
            cellModel.movieCd = dailyBoxOfficeValue.movieCd
            cellModel.movieNm = dailyBoxOfficeValue.movieNm
            cellModel.openDt = String.emojiAndTitle(emojiValue: .releasedDay) + " " + dailyBoxOfficeValue.openDt
            cellModel.salesAmt = dailyBoxOfficeValue.salesAmt
            cellModel.salesShare = dailyBoxOfficeValue.salesShare
            cellModel.salesInten = dailyBoxOfficeValue.salesInten
            cellModel.salesChange = dailyBoxOfficeValue.salesChange
            cellModel.salesAcc = dailyBoxOfficeValue.salesAcc
            cellModel.audiCnt = String.emojiAndTitle(emojiValue: .audCount) + " " + dailyBoxOfficeValue.audiCnt
            cellModel.audiInten = dailyBoxOfficeValue.audiInten
            cellModel.audiChange = dailyBoxOfficeValue.audiChange
            cellModel.audiAcc = dailyBoxOfficeValue.audiAcc
            cellModel.scrnCnt = dailyBoxOfficeValue.scrnCnt
            cellModel.showCnt = dailyBoxOfficeValue.showCnt
            cellModel.imageURLString = asyncMapped[index]
            return cellModel
        }
        timer.stop()
        print(">>>>")
    }
    
    private func findAndReturnSelectedItem(indexPathRow: Int) -> DailyBoxOfficeList? {
        guard let entity = entity else { return nil }
        return entity.boxOfficeResult.dailyBoxOfficeList[indexPathRow]
    }
}
