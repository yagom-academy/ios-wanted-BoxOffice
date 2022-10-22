//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    var model2: Model?
    
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
    
    func setModel(){
        boxOfficeRank.text = "\(model2?.boxOfficeRank2)순위"
        moiveName.text = model2?.moiveName2
        openingDate.text = model2?.openingDate2
        audience.text = model2?.audience2
        rankIncrease.text = model2?.rankIncrease2
        newEntry.text = model2?.newEntry2
        yearOfmanufacture.text = model2?.yearOfmanufacture2
        releaseYear.text = model2?.releaseYear2
        movieTime.text = model2?.movieTime2
        genre.text = model2?.genre2
        actorName.text = model2?.actorName2
        directioName.text = model2?.directioName2
        viewingLevel.text = model2?.viewingLevel2
    }
}
