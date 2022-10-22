//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    var model: Model?
    
    @IBOutlet var boxOfficeRank: UILabel!
    @IBOutlet var moiveName: UILabel!
    @IBOutlet var openingDate: UILabel!
    @IBOutlet var audience: UILabel!
    @IBOutlet var rankIncrease: UILabel!
    @IBOutlet var newEntry: UILabel!
    @IBOutlet var yearOfmanufacture: UILabel!
    @IBOutlet var releaseYear: UILabel!
    @IBOutlet var movieTime: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var actorName: UILabel!
    @IBOutlet var directioName: UILabel!
    @IBOutlet var viewingLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setModel()
    }
    
    func setModel() {
        boxOfficeRank.text = "\(model?.boxOfficeRank2)순위"
        moiveName.text = model?.moiveName2
        openingDate.text = model?.openingDate2
        audience.text = model?.audience2
        rankIncrease.text = model?.rankIncrease2
        newEntry.text = model?.newEntry2
        yearOfmanufacture.text = model?.yearOfmanufacture2
        releaseYear.text = model?.releaseYear2
        movieTime.text = model?.movieTime2
        genre.text = model?.genre2
        actorName.text = model?.actorName2
        directioName.text = model?.directioName2
        viewingLevel.text = model?.viewingLevel2
    }
    
}
