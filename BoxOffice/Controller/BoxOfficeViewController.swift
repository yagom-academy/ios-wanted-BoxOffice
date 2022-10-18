//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    let mainView = BoxOfficeView()
    var boxOfficeViewModel: BoxOfficeViewModel?
    var posterUrlList: [Int:String] = [:]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func configureImage() {
        posterUrlList = [:]
        guard let viewModel = self.boxOfficeViewModel else { return }
        for (index, model) in viewModel.listModel.enumerated() {
            
            let url = "\(EndPoint.naverURL)?query=\(model.movieNm)"
            APIService.shared.fetchImage(url: url) { (response: PosterModel?, error) in
                guard let response = response
                else {
                    return
                }
                guard let imageList = response.items.first else { return }
                self.posterUrlList[index] = imageList.image.replacingOccurrences(of: "mit110", with: "mit500")
                print(response.items.first?.title)
                self.mainView.boxOfficeTableView.reloadData()
            }
        }
    }
    
    func setup() {
        let today = Date().todayToString()
        //let url = "\(EndPoint.kdbDailyURL)?key=\(APIKey.KDB_KEY_ID)&targetDt=\(today)&wideAreaCd=0105001"
        let url = "\(EndPoint.kdbDailyURL)?key=\(APIKey.KDB_KEY_ID)&targetDt=\(today)"
        mainView.boxOfficeTableView.delegate = self
        mainView.boxOfficeTableView.dataSource = self
        mainView.boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        APIService.shared.fetchData(url: url) { (response: BoxOfficeModel?, error) in
            guard let response = response else {
                return
            }

            self.boxOfficeViewModel = BoxOfficeViewModel(viewModel: response)
            self.configureImage()
            self.setupNavigation()
        }
    }
    
    func setupNavigation() {
        navigationItem.title = boxOfficeViewModel?.boxofficeType
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension BoxOfficeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeViewModel?.listCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell
        else {
            return UITableViewCell()
        }
        guard let viewModel = boxOfficeViewModel
        else {
            return UITableViewCell()
        }
        let data = viewModel.boxOffice(row: indexPath.row)
        cell.rankLabel.text = "#\(data.rank)"
        cell.movieNameLabel.text = data.movieNm
        cell.audiAccLabel.text = data.audiAcc
        cell.inputRankInten(value: viewModel.rankChange(row: indexPath.row))
        cell.openDateLabel.text = data.openDt
        if let imageURL = posterUrlList[indexPath.row] {
            cell.posterView.setImageUrl(imageURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

