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

    tableView.separatorStyle = .none
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
    tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.id)
    tableView.register(ReviewCellHeaderView.self, forHeaderFooterViewReuseIdentifier: ReviewCellHeaderView.id)
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
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 1:
      return 5
    default:
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.id,
                                                     for: indexPath) as? MovieDetailCell
      else { return UITableViewCell() }

      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.id,
                                                     for: indexPath) as? ReviewCell
      else { return UITableViewCell() }

      return cell

    default:
      return UITableViewCell()
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 1 {
      guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReviewCellHeaderView.id)
              as? ReviewCellHeaderView
      else {
        return UITableViewHeaderFooterView()
      }

      return header
    } else {
      return UITableViewHeaderFooterView()
    }
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
