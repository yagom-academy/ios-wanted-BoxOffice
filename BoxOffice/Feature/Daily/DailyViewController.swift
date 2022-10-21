//
//  DailyViewController.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit

final class DailyViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let vm = DailyViewModel()
    private var dto: DailyDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        Task { [weak self] in
            guard let self = self else { return }
            
            dto = try await self.vm.fetchDailyView()
            self.collectionView.reloadData()
        }
    }
    
    func setupUI() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        
        let listNib = UINib(nibName: BoxOfficeCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(listNib, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
    }
}

extension DailyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dto?.dataSource.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dto?.dataSource[section].items.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dto?.dataSource[indexPath.section] else { return  UICollectionViewCell() }
        let row = dataSource.items[indexPath.row]
        
        switch row {
        case .dateSelector:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            return cell
        case .boxOffice(let boxOfficeData):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath)
            if let cell = cell as? BoxOfficeCell {
                cell.set(data: boxOfficeData)
            }
            return cell
        }
    }
}
