//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class DetailViewController : UIViewController{
    
    let detailView = DetailView()
            
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        addSubViews()
        setConstraints()
    }
    
    func setInfo(){
        detailView.setInfo(movie: movie!)
    }
    
    func addSubViews(){
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
