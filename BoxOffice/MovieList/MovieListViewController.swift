//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import SwiftUI

final class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}

struct MovieListViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = MovieListViewController()
            return UINavigationController(rootViewController: vc)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
        typealias UIViewControllerType = UIViewController
    }
}
