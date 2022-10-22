//
//  WeeklyViewController.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/17.
//

import UIKit

final class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let vm = WeeklyViewModel()
    private var dto: WeeklyDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        fetchData()
    }
    
    func setupUI() {
        guard let lastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()),
              let lastWeekend = Calendar.current.date(byAdding: .day, value: 1, to: lastWeek) else { return }

        self.datePicker.date = lastWeekend
        self.datePicker.maximumDate = lastWeekend
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        
        let listNib = UINib(nibName: BoxOfficeCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(listNib, forCellWithReuseIdentifier: BoxOfficeCell.identifier)
    }
    
    func fetchData(weekGb: Int = 1) {
        Task { [weak self] in
            guard let self = self else { return }
            
            let targetDt = self.datePicker.date.dateString
            let (dto, range) = try await self.vm.fetchWeeklyView(targetDt: targetDt, weekGb: weekGb)
            self.dto = dto
            self.rangeLabel.text = range
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func didEndEditingDatePicker(_ sender: Any) {
        let date = self.datePicker.date
        let weekday = self.datePicker.calendar.component(.weekday, from: date)
        if (1...5).contains(weekday) {
            fetchData(weekGb: 2)
        } else {
            fetchData()
        }
        
    }
}

extension WeeklyViewController: UICollectionViewDataSource {
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
        case .boxOffice(let boxOfficeData):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.identifier, for: indexPath)
            if let cell = cell as? BoxOfficeCell {
                cell.set(data: boxOfficeData)
            }
            return cell
        }
    }
}

extension WeeklyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = dto?.dataSource[indexPath.section] else { return }
        let row = dataSource.items[indexPath.row]
        
        switch row {
        case .boxOffice(let boxOfficeData):
            guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WeeklyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let dataSource = dto?.dataSource[indexPath.section] else { return .zero }
        let row = dataSource.items[indexPath.row]
        
        switch row {
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
