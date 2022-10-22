//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

class BoxOfficeView: UIView {
    
    let boxOfficeTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        return view
    }()
    
    let segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["일간","주간"])
        view.selectedSegmentIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(boxOfficeTableView)
        addSubview(segmentControl)
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            boxOfficeTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            boxOfficeTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
}
