//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    let networkManager = NetworkManager()
    private var boxOfficeInfo = [BoxOfficeInfo]()
    
    let listView = BoxOfficeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultSetting()
    }
    
    private func configureDefaultSetting() {
        self.view.backgroundColor = .white
        self.view.addSubview(listView)
        self.listView.boxOfficeCollectionView.dataSource = self
        self.listView.boxOfficeCollectionView.delegate = self
        
        let api = EndPoints.makeBoxOfficeApi(
            key: APIKey.movieInfo.rawValue,
            date: DateFormatterManager.shared.convertToDateString(from: Date())
        )
        
        networkManager.dataTask(api: api) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let dailyBoxOfficeData: BoxOfficeResult = JSONManager.shared.decodeToInfo(
                        from: data
                      ) else { return }
                self.boxOfficeInfo = dailyBoxOfficeData.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //TODO: 데이터 불러 오는 작업 (총 4번의 비동기 처리)
    
    //TODO: Cell 생성하는 로직 구현
}

extension BoxOfficeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.boxOfficeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
