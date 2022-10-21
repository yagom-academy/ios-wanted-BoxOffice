//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class MovieListViewController: UIViewController {

  private var networkManager = NetworkManager()
  private var dailyList = [RankListObject?](repeating: nil, count: 10)
  private var weeklyList = [RankListObject?](repeating: nil, count: 10)
  private var dailyMovieInfoList = [MovieInfo?](repeating: nil, count: 10)
  private var weeklyMovieInfoList = [MovieInfo?](repeating: nil, count: 10)
  private var posterList = [String](repeating: "", count: 10)
  private var dailyCount = 0
  private var weeklyCount = 0
  private var segmentIndex = 0

  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "YYYYMMdd"

    return df
  }()

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

//    print(dailyList.first == nil)
//    print(dailyList[0] == nil)

    if dailyCount == 0 {
      let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!

      DispatchQueue.global().async {
        self.networkManager.fetchMovie(targetDate: self.dateFormatter.string(from: yesterday),
                                       type: .daily)
      }
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
      segmentIndex = 0
      tableView.reloadData()

    case 1:
      print("1111")

      segmentIndex = 1

      if weeklyCount == 0 {
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        print(lastWeek)
        DispatchQueue.global().async {
          self.networkManager.fetchMovie(targetDate: self.dateFormatter.string(from: lastWeek),
                                         type: .weekly)
        }
      } else {
        tableView.reloadData()
      }
      
    default:
      print("segment error")
    }
  }
}

// MARK: - TableView Delegate, Datasource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if segmentIndex == 0 {
      return dailyCount
    } else {
      return weeklyCount
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.id,
                                                   for: indexPath) as? MovieListCell
    else { return UITableViewCell() }

    let i = indexPath.row

    if segmentIndex == 0 {
      guard let movie = dailyList[i] else { return UITableViewCell() }

      cell.setLabels(rank: movie.rank,
                     title: movie.movieNm,
                     date: movie.openDt,
                     audiCnt: movie.audiAcc,
                     diff: movie.rankInten)
      cell.setPoster(PosterCache.loadPoster(movie.movieCd))

      let updown = Int(movie.rankInten)!
      if updown == 0 {
        cell.changeRankUpDown(.nothing)
      } else if updown > 0 {
        cell.changeRankUpDown(.up)
      } else {
        cell.changeRankUpDown(.down)
      }

      cell.toggleNewTag(movie.rankOldAndNew == "NEW")

      return cell

    } else {
      guard let movie = weeklyList[i] else { return UITableViewCell() }

      cell.setLabels(rank: movie.rank,
                     title: movie.movieNm,
                     date: movie.openDt,
                     audiCnt: movie.audiAcc,
                     diff: movie.rankInten)
      cell.setPoster(PosterCache.loadPoster(movie.movieCd))

      let updown = Int(movie.rankInten)!
      if updown == 0 {
        cell.changeRankUpDown(.nothing)
      } else if updown > 0 {
        cell.changeRankUpDown(.up)
      } else {
        cell.changeRankUpDown(.down)
      }

      cell.toggleNewTag(movie.rankOldAndNew == "NEW")

      return cell
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let nextVC = MovieDetailViewController()
    let i = indexPath.row

    if segmentIndex == 0 {
      nextVC.title = dailyList[i]?.movieNm
      nextVC.rankInfo = dailyList[i]
      nextVC.movieInfo = dailyMovieInfoList[i]

      navigationController?.pushViewController(nextVC, animated: true)

    } else {
      nextVC.title = weeklyList[i]?.movieNm
      nextVC.rankInfo = weeklyList[i]
      nextVC.movieInfo = weeklyMovieInfoList[i]

      navigationController?.pushViewController(nextVC, animated: true)
    }
  }

}

extension MovieListViewController: NetworkDelegate {
  func didUpdateBoxOfficeList(_ _result: [RankListObject], _ type: BoxOfficeType) {

    switch type {
    case .daily:
      dailyCount = _result.count

      _result.forEach {
        let i = Int($0.rank)! - 1
        dailyList[i] = $0
      }

      for i in 0 ..< 10 {
        guard let movieCode = dailyList[i]?.movieCd else { break }

        DispatchQueue.global().async {
          self.networkManager.fetchMovie(movieCode: movieCode, index: i, type: type)
        }
      }

    case .weekly:
      weeklyCount = _result.count

      _result.forEach {
        let i = Int($0.rank)! - 1
        weeklyList[i] = $0
      }

      for i in 0 ..< 10 {
        guard let movieCode = weeklyList[i]?.movieCd else { break }

        DispatchQueue.global().async {
          self.networkManager.fetchMovie(movieCode: movieCode, index: i, type: type)
        }
      }
    }
  }

  func didUpdateMovieInfo(_ _movieInfo: MovieInfo, _ index: Int, _ type: BoxOfficeType) {

    switch type {
    case .daily:
      dailyMovieInfoList[index] = _movieInfo

      guard let openDate = dailyList[index]?.openDt else { return }
      guard let movieCode = dailyList[index]?.movieCd else { return }

      let year = openDate.split(separator: "-").map { String($0) }.first!

      DispatchQueue.global().async {
        self.networkManager.fetchMovie(movieName: _movieInfo.movieNmEn,
                                       year: year,
                                       movieCode: movieCode,
                                       index: index)
      }

    case .weekly:
      weeklyMovieInfoList[index] = _movieInfo

      guard let openDate = weeklyList[index]?.openDt else { return }
      guard let movieCode = weeklyList[index]?.movieCd else { return }

      let year = openDate.split(separator: "-").map { String($0) }.first!

      DispatchQueue.global().async {
        self.networkManager.fetchMovie(movieName: _movieInfo.movieNmEn,
                                       year: year,
                                       movieCode: movieCode,
                                       index: index)
      }
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
