//
//  UIPreview.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/18.
//

import SwiftUI

#if canImport(SwiftUI) && DEBUG
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
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> some UIView {
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
#endif
