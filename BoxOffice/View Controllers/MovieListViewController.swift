//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class MovieListViewController: UIViewController {

    // MARK: UI

    @IBOutlet var tableView: UITableView!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()
    private var movieList: [Movie] = []

    // MARK: View Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension MovieListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        let movie = movieList[indexPath.row]
        cell.rankingLabel.text = movie.ranking.string
        cell.nameLabel.text = movie.name
        cell.openDateLabel.text = "\(movie.openDate.dateString()) 개봉"
        cell.numberOfMoviegoersLabel.text = "누적관객 \(movie.numberOfMoviegoers.string)명"
        cell.isNewRankingLabel.text = movie.isNewRanking ? "NEW" : nil
        if movie.changeRanking == 0 {
            cell.changeRankingInfoView.removeFromSuperview()
        } else {
            let up = movie.changeRanking > 0
            cell.changeRankingLabel.text = movie.changeRanking.string
            cell.changeRankingImageView.image = up ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill")
            cell.changeRankingLabel.textColor = up ? .systemPink : .systemBlue
            cell.changeRankingImageView.tintColor = up ? .systemPink : .systemBlue
        }
        return cell
    }

}

extension MovieListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        // TODO: 두번째화면으로 이동
    }
    
}
