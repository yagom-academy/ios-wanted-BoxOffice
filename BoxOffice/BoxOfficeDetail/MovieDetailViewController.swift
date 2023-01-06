//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let boxOfficeData: BoxOffice
    private let boxofficeDetailAPI = BoxOfficeDetailAPI()
    private let moviePosterAPI = MoviePosterAPI()
    private var movieData: MovieDetailInfo?
    private var moviePosterData: MoviePosterInfo?
    private let URLSemaphore = DispatchSemaphore(value: 0)
    
    let movieDetailView: MovieDetailView = {
        let view = MovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.fetchData()
        self.fetchPosterData()
        movieDetailView.fetchMovieDetailData(posterData: moviePosterData, movieData: movieData
                                             , boxOfficeData: boxOfficeData)
        configureUI()
    }
    
    init(boxOffice: BoxOffice) {
        self.boxOfficeData = boxOffice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        boxofficeDetailAPI.dataTask(by: self.boxOfficeData.movieCD, completion: { (response) in
            switch response {
            case .success(let data):
                self.movieData = data
                self.URLSemaphore.signal()
            case .failure(let data):
                print(data)
            }
        })
        self.URLSemaphore.wait()
    }
    
    private func fetchPosterData() {
        guard let movieDataName = self.movieData?.movieInfoResult.movieInfo.movieNmEn else { return }
        
        moviePosterAPI.dataTask(by: movieDataName, completion: { (response) in
            switch response {
            case .success(let data):
                self.moviePosterData = data
                self.URLSemaphore.signal()
            case .failure(let data):
                print(data)
            }
        })
        self.URLSemaphore.wait()
    }
    
}

extension MovieDetailViewController {
    private func configureUI() {
        self.view.addSubview(self.movieDetailView)
        setUpBaseUIConstraints()
    }
    
    private func setUpBaseUIConstraints() {
        movieDetailView.insetsLayoutMarginsFromSafeArea = false
        
        NSLayoutConstraint.activate([
            self.movieDetailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.movieDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.movieDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.movieDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
