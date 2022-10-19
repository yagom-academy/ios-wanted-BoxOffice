//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/20.
//

import UIKit

class MovieDetailViewController: UIViewController {

  let tableView = UITableView(frame: .zero, style: .plain)

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(shareButtonPressed))
    navigationController?.navigationBar.tintColor = .black

    tableView.delegate = self
    tableView.dataSource = self

    addViews()
    setConstraints()
  }
}

extension MovieDetailViewController {
  func addViews() {
    view.addSubview(tableView)
    tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.id)
  }

  func setConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  @objc func shareButtonPressed() {
    print("shaaaaaaaaaaare")
  }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.id,
                                                   for: indexPath) as? MovieDetailCell
    else { return UITableViewCell() }

    return cell
  }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MovieDetailVC_Preview: PreviewProvider {
  static var previews: some View {
    MovieDetailViewController().showPreview()
  }
}
#endif
