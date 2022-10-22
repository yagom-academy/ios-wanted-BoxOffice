//
//  FirstContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import UIKit

class FirstContentView: UIView, ActivityIndicatorViewStyling {
    
    //input
    
    //output
    
    //properties
    var tableView: UITableView = UITableView()
    private let movieCell_Identifier = "FirstMovieCell"
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var viewModel: FirstContentViewModel
    
    init(viewModel: FirstContentViewModel) {
        print(#function)
        self.viewModel = viewModel
        super.init(frame: .zero)
        initViewHierarchy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FirstContentView: Presentable {
    func initViewHierarchy() {
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        constraint += [
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
    }
    
    func configureView() {
        tableView.register(FirstMovieCell.self, forCellReuseIdentifier: movieCell_Identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        //        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
                
                
        //        tableView.contentInsetAdjustmentBehavior = .never
        //        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        //        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        //        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        
        activityIndicator.addStyles(style: indicatorStyle)
    }
    
    func bind() {
        
        viewModel.didReceiveViewModel = { [weak self] _ in
            guard let self = self else { return }
            print("didReceiveViewModel")
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
        viewModel.turnOnIndicator = { [weak self] _ in
            guard let self = self else { return }
            self.tableView.isHidden = true
            self.activityIndicator.startAnimating()
        }
        
        viewModel.turnOffIndicator = { [weak self] _ in
            guard let self = self else { return }
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    
}

extension FirstContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemInTableView(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FirstContentView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCell_Identifier, for: indexPath) as? FirstMovieCell else { fatalError() }
        
        cell.configureCell(viewModel: viewModel.dataSource[indexPath.row])
        return cell
    }
    
    // TODO: willDisplay willDisppear 이용한 이미지 처리 고도화
    
    
}
