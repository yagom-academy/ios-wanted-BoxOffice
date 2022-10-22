//
//  BasicNavigationController.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import UIKit

class BasicNavigationController: UINavigationController, BasicNavigationBarStyling {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewHierarchy()
        configureView()
        bind()
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

extension BasicNavigationController: Presentable {
    func initViewHierarchy() {
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func configureView() {
        navigationBar.addStyles(style: navigationBarStyle)
    }
    
    func bind() {
        
    }
}
