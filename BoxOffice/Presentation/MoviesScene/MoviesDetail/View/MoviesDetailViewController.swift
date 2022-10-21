//
//  MoviesDetailViewController.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    var viewModel: MoviesDetailItemViewModel?
    var repository: MoviesRepository?
    
    init(viewModel: MoviesDetailItemViewModel, repository: MoviesRepository) {
        self.viewModel = viewModel
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        fetchMovie()
        setupViews()
        setupConstraints()
        bind()
        setNavigationbar()
    }
    
}

extension MoviesDetailViewController {
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func bind() {
        
    }
    
    func setNavigationbar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

extension MoviesDetailViewController {
    func fetchMovie() {
        self.repository?.fetchMoviesDetail(movieId: self.viewModel?.movieCd ?? "", completion: { response in
            switch response {
            case .success(let movieDetail):
                self.viewModel?.prdtYear = movieDetail.prdtYear
                self.viewModel?.showTm = movieDetail.showTm
                self.viewModel?.genreNm = movieDetail.genreNm
                self.viewModel?.directorsNm = movieDetail.directorsNm
                self.viewModel?.actorsNm = movieDetail.actorsNm
                self.viewModel?.watchGradeNm = movieDetail.watchGradeNm
                
            case .failure(_):
                print("FETCH ERROR")
            }
        })
    }
}
