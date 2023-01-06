//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published var detailInformation: MovieDetail = MovieDetail(openDate: "",
                                                                productionYear: "",
                                                                showTime: "",
                                                                typeName: "",
                                                                directors: [],
                                                                actors: [],
                                                                genres: [],
                                                                audits: [], movieEnglishName: "",
                                                                movieKoreaName: "")

private let session = MyURLSession()

    func fetchMovieDetail(movieCode: String) {
        let request = KobisMovieDetailAPIRequest(movieCode: movieCode)

        session.execute(request) { result in
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self.detailInformation = movieDetail.movieDetailResult.movieDetail
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
