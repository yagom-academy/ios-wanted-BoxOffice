//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieListViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.title = "Box Office"
    self.view.backgroundColor = .white
  }


}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIViewController {
  struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
      return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
  }

  func showPreview() -> some View {
    ViewControllerPreview(viewController: self)
  }
}
#endif

#if canImport(SwiftUI) && DEBUG
struct MovieListVC_Preview: PreviewProvider {
  static var previews: some View {
    MovieListViewController().showPreview()
  }
}
#endif
