//
//  ContentView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankView: View {

    enum Rank {

    }
    @ObservedObject var viewModel = MovieRankViewModel()
    @State var posters: [UIImage] = []
    @State var noImage: UIImage = (UIImage(systemName: "x.circle") ?? UIImage())

    var body: some View {
        Group {
            List(viewModel.boxOfficeList, id: \.rank) { movie in
                NavigationLink(destination:
                                MovieDetailView(poster: posters.count <= Int(movie.rank) ?? 0 - 1 ? $noImage : $posters[Int(movie.rank) ?? 0 - 1], boxOfficeMovie: movie)) {
                    MovieRankRowView(movie: movie, poster: posters.count <= Int(movie.rank) ?? 0 - 1 ? $noImage : $posters[Int(movie.rank) ?? 0 - 1])
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
                viewModel.fetchPoster() { result in
                    switch result {
                    case .success(let data):
                        posters.append(UIImage(data: data) ?? UIImage())
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankView()
    }
}
