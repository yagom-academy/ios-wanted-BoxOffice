//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import Combine
import OSLog

final class MovieListViewController: UIViewController {

    // MARK: UI

    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()

    @Published private var movies: [MovieRanking] = []
    private var cancellables: Set<AnyCancellable> = .init()

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchMovieRanking()
    }

    // MARK: -

    private func configureObserver() {
        $movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func fetchMovieRanking() {
        Task {
            do {
                let movies = try await movieSearchService.searchMovieRanking(for: .daily)
                self.movies = movies
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: Navigation

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

// MARK: - UITableViewDataSource

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
