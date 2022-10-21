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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        Task {
            let result = try await self.vm.fetchDailyView()
            print(result)
        }
    }
    
    func setupUI() {
        let listNib = UINib(nibName: ListCollectionViewCell.identifier, bundle: Bundle(for: self.classForCoder))
        self.collectionView.register(listNib, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
}

extension DailyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}
