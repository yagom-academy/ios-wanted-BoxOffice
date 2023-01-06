//
//  MovieRankViewModel.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation
import UIKit.UIImage

final class MovieRankViewModel: ObservableObject {

    @Published var boxOfficeList: [BoxOfficeMovie] = []
    private let session = MyURLSession()

    func fetchPoster(completion: @escaping (Result<Data, APIError>) -> Void) {
        let boxOfficeRequest = KobisDailyBoxOfficeAPIRequest()

        session.execute(boxOfficeRequest) { result in
            switch result {
            case .success(let boxOffice):
                let sortedArray = boxOffice.boxOfficeResult.dailyBoxOfficeList.sorted { $0.rank > $1.rank }
                
                sortedArray .forEach { information in
                    DispatchQueue.main.async {
                        self.boxOfficeList = boxOffice.boxOfficeResult.dailyBoxOfficeList
                    }
                    let movieDetailRequest = KobisMovieDetailAPIRequest(movieCode: information.movieCode)

                    self.session.execute(movieDetailRequest) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let detail):

                            let posterRequest = OMDbPosterAPIRequest(movieEnglishName: detail.movieDetailResult.movieDetail.movieEnglishName, openDateYear: String(detail.movieDetailResult.movieDetail.openDate.substring(from: 0, to: 3)))

                            self.session.execute(posterRequest) { [weak self] result in
                                switch result {
                                case .success(let omdb):
                                    guard let self = self else { return }

                                    guard let url = URL(string: omdb.poster) else { return }
                                    let imageRequest = URLRequest(url: url)
                                    print(url.description)
                                    self.session.networkPerform(for: imageRequest, completion: completion)

                                case .failure(let error):
                                    print(error.localizedDescription)
                                    print("omdb에서 url")
                                }
                            }

                        case .failure(let error):
                            print(error.localizedDescription)
                            print("영화 상세 정보")
                        }
                    }
                }
            case .failure(_):
                print("영화코드 실패")
            }
        }
    }
}
