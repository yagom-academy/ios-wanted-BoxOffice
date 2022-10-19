//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import SwiftUI

final class MovieListViewController: UIViewController {
    
    private let movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        return indicator
    }()
    
    private let viewModel: MovieListViewModel = .init()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.settingNavigation()
        self.setupLayouts()
        self.configure(movieListCollectionView)
        self.setupViewModel()
        
    }
    
    private func settingNavigation() {
        self.navigationItem.title = "\(viewModel.targetDate) 순위"
    }
    
    private func setupViewModel() {
        self.viewModel.loadingStart = { [weak self] in
            self?.indicator.startAnimating()
        }
        
        self.viewModel.updateMovieList = { [weak self] in
            self?.movieListCollectionView.reloadData()
        }
        
        self.viewModel.loadingEnd = { [weak self] in
            self?.indicator.stopAnimating()
        }
        self.viewModel.requestMovieList(target: "20221017")
        print("🍎 \(viewModel.movieList)")
    }
    
    // MARK: - Private func
    private func setupLayouts() {
        self.view.addSubViewsAndtranslatesFalse(movieListCollectionView,
                                                indicator)
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieListCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            movieListCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            movieListCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 40),
            indicator.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.view.bringSubviewToFront(self.indicator)
        
    }
    
    private func configure(_ colletionView: UICollectionView) {
        colletionView.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
        colletionView.dataSource = self
        colletionView.delegate = self
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMovieListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else { return UICollectionViewCell() }
        cell.configure(viewModel.movieList[indexPath.row])
        return cell
    }
    
    
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.movieListModel = viewModel.movieList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: dynamic height ~ing
        return CGSize(width: self.view.frame.width, height: 120)
    }
}
//
//struct MovieListViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let vc = MovieListViewController()
//            return UINavigationController(rootViewController: vc)
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//        
//        typealias UIViewControllerType = UIViewController
//    }
//}
