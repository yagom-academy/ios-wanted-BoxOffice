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
    @Published var posters: [UIImage] = Array<UIImage>(repeating: UIImage(named: "noImage") ?? UIImage(), count: Int(BoxOfficeItemPerPage.constant.rawValue) ?? 0)
    private let session = MyURLSession()

    init() {
        fetchMovie()
    }

    func fetchMovie() {
        let boxOfficeRequest = KobisDailyBoxOfficeAPIRequest()

        session.execute(boxOfficeRequest) { result in
            switch result {
            case .success(let boxOffice):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.boxOfficeList = boxOffice.boxOfficeResult.dailyBoxOfficeList
                }

                for (index, information) in self.boxOfficeList.enumerated() {
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
                                    self.session.networkPerform(for: imageRequest) { result in
                                        switch result {
                                        case .success(let data):
                                            DispatchQueue.main.async {
                                                self.posters[index] = UIImage(data: data) ?? UIImage()
                                            }
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                        }
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
