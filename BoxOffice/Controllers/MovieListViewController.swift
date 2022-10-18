//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieListViewController: UIViewController {

  let segmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["일별", "주간"])
    sc.selectedSegmentIndex = 0
    return sc
  }()

  let tableView = UITableView(frame: .zero, style: .plain)

  let paddedStack: UIStackView = {
    let sc = UIStackView()
    sc.layoutMargins = .init(top: 11, left: 30, bottom: 11, right: 30)
    sc.isLayoutMarginsRelativeArrangement = true
    return sc
  }()

  let verticalStack: UIStackView = {
    let sc = UIStackView()
    sc.axis = .vertical
    return sc
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.title = "Box Office"
    self.view.backgroundColor = .white

    addViews()
    addTargets()
    setConstraints()
  }
}

extension MovieListViewController {
  func addViews() {
    paddedStack.addArrangedSubview(segmentedControl)
    [paddedStack, tableView].forEach { verticalStack.addArrangedSubview($0) }
    view.addSubview(verticalStack)
  }

  func setConstraints() {
    verticalStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  func addTargets() {
    segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
  }

  @objc func segmentChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      print("0000")
    case 1:
      print("1111")
    default:
      print("segment error")
    }
  }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()

    return cell
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
