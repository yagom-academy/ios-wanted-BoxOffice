//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import Combine

final class MovieListViewController: UIViewController {

    // MARK: UI

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var segmentedControl: UISegmentedControl!

    // MARK: Properties

    private let movieSearchService = MovieSearchService()

    @Published private var movies: [MovieRanking] = []
    private var cancellables: Set<AnyCancellable> = .init()

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonDisplayMode = .minimal
        subscribe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchMovieRanking()
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MovieDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let movie = movies[indexPath.row]
        destination.movieRanking = movie
    }

    // MARK: Action Handler

    @IBAction
    private func segmentedControlValueChanged() {
        fetchMovieRanking()
    }

    private func subscribe() {
        $movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func fetchMovieRanking() {
        guard let duration = DurationUnit(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        Task {
            do {
                let movies = try await movieSearchService.searchMovieRanking(for: duration)
                self.movies = movies
            } catch let error {
                print(error.localizedDescription)
            }
        }
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
        cell.movieRankingView.updateView(with: movie)
        return cell
    }

}
