//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {
    
    let movieDetailView: SecondView = {
        let view = SecondView()
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
        configureUI()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController {
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
