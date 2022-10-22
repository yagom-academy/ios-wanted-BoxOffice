//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import UIKit
import SwiftUI

class ThirdViewController: UIViewController {

    var model: ThirdModel
    
    lazy var contentView: ThirdContentView = ThirdContentView(viewModel: self.model.thirdContentViewModel)
    lazy var hostingVC: UIHostingController = UIHostingController(rootView: contentView)
    
    init(viewModel: ThirdModel) {
        self.model = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        initViewHierarchy()
        configureView()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThirdViewController: Presentable {
    func initViewHierarchy() {
        self.view = UIView()
        
        self.addChild(hostingVC)
        hostingVC.view.frame = self.view.bounds
        self.view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            hostingVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            hostingVC.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
    
    func configureView() {
        self.view.backgroundColor = .white
        self.title = "리뷰"
    }
    
    func bind() {
        
    }
    
    
}
