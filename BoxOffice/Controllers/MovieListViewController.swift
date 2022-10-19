//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieListViewController: UIViewController {

  private var networkManager = NetworkManager()
  private var dailyList = [DailyListObject?](repeating: nil, count: 10)
  private var movieInfoList = [MovieInfo?](repeating: nil, count: 10)
  private var posterList = [String](repeating: "", count: 10)
  private var movieCount = 0

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

    tableView.delegate = self
    tableView.dataSource = self
    networkManager.delegate = self

    DispatchQueue.global().async {
      self.networkManager.fetchMovie(targetDate: "20221018", type: .daily)
    }

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

    tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.id)
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

// MARK: - TableView Delegate, Datasource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.id,
                                                   for: indexPath) as? MovieListCell
    else { return UITableViewCell() }

    let i = indexPath.row

    guard let movie = dailyList[i] else { return UITableViewCell() }

    cell.setLabels(rank: movie.rank,
                   title: movie.movieNm,
                   date: movie.openDt,
                   audiCnt: movie.audiCnt,
                   diff: movie.rankInten)
    cell.setPoster(PosterCache.loadPoster(movie.movieCd))

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("select cell \(indexPath.row), \(dailyList[indexPath.row]!.movieCd)",
          posterList[indexPath.row])
  }

}

extension MovieListViewController: NetworkDelegate {
  func didUpdateBoxOfficeList(_ _dailyList: [DailyListObject]) {
    movieCount = _dailyList.count

    _dailyList.forEach {
      let i = Int($0.rank)! - 1
      dailyList[i] = $0
    }

    for i in 0 ..< 10 {
      guard let movieCode = dailyList[i]?.movieCd else { break }

      DispatchQueue.global().async {
        self.networkManager.fetchMovie(movieCode: movieCode, index: i)
      }
    }
  }

  func didUpdateMovieInfo(_ _movieInfo: MovieInfo, _ index: Int) {
    movieInfoList[index] = _movieInfo

    guard let openDate = dailyList[index]?.openDt else { return }
    guard let movieCode = dailyList[index]?.movieCd else { return }

    let year = openDate.split(separator: "-").map { String($0) }.first!

    DispatchQueue.global().async {
      self.networkManager.fetchMovie(movieName: _movieInfo.movieNmEn,
                                year: year,
                                movieCode: movieCode,
                                index: index)
    }
  }

  func didUpdatePosterInfo(_ _imagePath: String, _ index: Int) {
    posterList[index] = _imagePath
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
//    tableView.reloadData()
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MovieListVC_Preview: PreviewProvider {
  static var previews: some View {
    MovieListViewController().showPreview()
  }
}
#endif
