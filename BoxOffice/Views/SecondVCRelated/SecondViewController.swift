//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import UIKit
import SwiftUI

class SecondViewController: UIViewController {

    lazy var contentView = SecondContentView()
    
    var model: SecondModel
    
    init(viewModel: SecondModel) {
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
        model.populateData()
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

extension SecondViewController: Presentable {
    func initViewHierarchy() {
        self.view = UIView()
        
        let hostingVC = UIHostingController(rootView: contentView)
        
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
    
    /* UIHostingVC and Add ChildVC
     let childView = UIHostingController(rootView: SwiftUIView())
             addChild(childView)
             childView.view.frame = theContainer.bounds
             theContainer.addSubview(childView.view)
             childView.didMove(toParent: self)
     */
    
    /* Adding a child view controller to a container
     - (void) displayContentController: (UIViewController*) content {
        [self addChildViewController:content];
        content.view.frame = [self frameForContentController];
        [self.view addSubview:self.currentClientView];
        [content didMoveToParentViewController:self];
     }
     */
    
    /* Removing a child view controller from a container
     - (void) hideContentController: (UIViewController*) content {
        [content willMoveToParentViewController:nil];
        [content.view removeFromSuperview];
        [content removeFromParentViewController];
     }

     */
    
    func configureView() {
        self.title = "상세정보"
        self.view.backgroundColor = .white
    }
    
    func bind() {
        
    }
    
    
}
