//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    let boxOfficeView: BoxOfficeView = {
        let view = BoxOfficeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubView()
        configure()
    }
    
    func addSubView() {
        view.addSubview(boxOfficeView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            boxOfficeView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boxOfficeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

