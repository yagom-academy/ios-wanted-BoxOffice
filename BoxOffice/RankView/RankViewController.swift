//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class RankViewController: UIViewController {
    
    let rankView = RankView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        addSubViews()
        setConstraints()
        rankView.delegate = self
    }
    
    func fetch(){
        MovieService().getMovieInfo { result in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    self.rankView.boxOfficeResponse = response
                    self.rankView.setInfo()
                    self.rankView.tableView.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }

    func addSubViews(){
        view.addSubview(rankView)
        rankView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            rankView.topAnchor.constraint(equalTo: self.view.topAnchor),
            rankView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            rankView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rankView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

}

extension RankViewController : RankViewProtocol{
    func presentDetailView() {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
