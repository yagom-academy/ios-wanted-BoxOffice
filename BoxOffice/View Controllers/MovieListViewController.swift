//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import OSLog

final class MovieListViewController: UIViewController {

    // MARK: UI

    @IBOutlet var tableView: UITableView!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()
    private var movies: [MovieRanking] = []

    // MARK: View Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: 데이터요청
        movieSearchService.searchMovieRanking(for: .daily) { movies in
            self.movies = movies
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MovieDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let movie = movies[indexPath.row]
        destination.movie = movie
    }

    // MARK: Action Handler

    @IBAction
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        Logger.ui.debug("\(#function) \(sender.selectedSegmentIndex)")

        guard let selectedDuration = DurationUnit(rawValue: sender.selectedSegmentIndex) else { return }
        // TODO: 데이터요청
    }

}

extension MovieListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.movieRankingView.configure(with: movie)
        return cell
    }

}
