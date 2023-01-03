//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkManager().getFilmData { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
        print(DateManager().getCurrentDate())
    }
}

