//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    let mainView = BoxOfficeView()
    let boxOfficeViewModel: BoxOfficeViewModel
    
    
    init() {
        self.boxOfficeViewModel = BoxOfficeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        fetchData()
        mainView.boxOfficeTableView.delegate = self
        mainView.boxOfficeTableView.dataSource = self
        mainView.boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeCellViewModel.identifier)
        mainView.segmentControl.addTarget(self, action: #selector(segmentControlDidChange(segment:)), for: .valueChanged)
    }
    
    @objc func segmentControlDidChange(segment: UISegmentedControl) {
        boxOfficeViewModel.segmentFlag = segment.selectedSegmentIndex
        fetchData()
    }
    
    func fetchData() {
        boxOfficeViewModel.clearCellViewModel()
        
        LoadingIndicator.showLoading()
        boxOfficeViewModel.fetchAPIData {
            self.mainView.boxOfficeTableView.reloadData()
            self.setupNavigation()
            LoadingIndicator.hideLoading()
        }
    }
    
    func setupNavigation() {
        navigationItem.title = boxOfficeViewModel.BoxOfficeModel?.boxOfficeResult.boxofficeType
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension BoxOfficeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeViewModel.cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.boxOfficeViewModel.cellViewModel[indexPath.row] else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: viewModel).identifier, for: indexPath) as? BoxOfficeTableViewCell
        else {
            return UITableViewCell()
        }
        switch ( cell, viewModel ){
        case let ( cell, viewModel) as (BoxOfficeTableViewCell, BoxOfficeCellViewModel):
            cell.cellViewModel = viewModel
        default:
            fatalError()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = self.boxOfficeViewModel.cellViewModel[indexPath.row] else { return }
        let dailyBoxOffice = viewModel as! BoxOfficeCellViewModel
        let vc = MovieInfoViewController(dailyBoxOffice: dailyBoxOffice.cellData)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}

