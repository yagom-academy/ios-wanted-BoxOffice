//
//  DailyViewController.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit

final class DailyViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let vm = DailyViewModel()
    private var dto: DailyDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        fetchData()
    }
    
    func setupUI() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        self.datePicker.date = yesterday
        self.datePicker.maximumDate = yesterday
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        
        let listNib = UINib(nibName: BoxOfficeCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(listNib, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
    }
    
    func fetchData() {
        Task { [weak self] in
            guard let self = self else { return }
            
            let targetDt = self.datePicker.date.dateString
            dto = try await self.vm.fetchDailyView(targetDt)
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func didEndEditingDatePicker(_ sender: Any) {
        fetchData()
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
        guard let dataSource = dto?.dataSource[indexPath.section] else { return UICollectionViewCell() }
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

extension DailyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let dataSource = dto?.dataSource[indexPath.section] else { return .zero }
        let row = dataSource.items[indexPath.row]
        
        switch row {
        case .dateSelector:
            return .zero
        case .boxOffice(let boxOfficeData):
            let width = UIScreen.main.bounds.width - 16
            guard let boxOfficeCell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath) as? BoxOfficeCell else { return .zero }
            let estimatedSize = boxOfficeCell.getEstimatedSize(data: boxOfficeData)
            return CGSize(width: width, height: estimatedSize.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
