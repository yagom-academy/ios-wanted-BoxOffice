//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import UIKit
import SwiftUI

final class MovieDetailViewController: UIViewController {
    
    private let boxOfficeRank: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교"
        label.numberOfLines = 0
        return label
    }()
    
    private let movieTitleEngAndproductYear: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Orphan: First Kill, 2022/01/23"
        label.numberOfLines = 0
        return label
    }()
    
    private let productYear: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "2022/01/23"
        return label
    }()
    
    private let mainInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let movieDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let viewModel: MovieDetailViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayouts()
        self.configure(movieDetailTableView)
    }
    
    private func configure(_ tableView: UITableView) {
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: "MovieDetailCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupLayouts() {
        
        [boxOfficeRank,movieTitle,movieTitleEngAndproductYear].forEach {
            self.mainInfoStackView.addArrangedSubview($0)
        }
        
        self.view.addSubViewsAndtranslatesFalse(
            mainInfoStackView,lineView,movieDetailTableView
        )
        
        NSLayoutConstraint.activate([
            self.mainInfoStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.mainInfoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.mainInfoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
        NSLayoutConstraint.activate([
            self.lineView.topAnchor.constraint(equalTo: self.mainInfoStackView.bottomAnchor, constant: 20),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),
            self.lineView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.lineView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            self.movieDetailTableView.topAnchor.constraint(equalTo: self.lineView.topAnchor, constant: 10),
            self.movieDetailTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.movieDetailTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.movieDetailTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as? MovieDetailCell else { return UITableViewCell() }
        
        return cell
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

struct MovieDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = MovieDetailViewController()
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
        
        typealias UIViewControllerType = UIViewController
    }
}
