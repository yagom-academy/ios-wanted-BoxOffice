//
//  ContentView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankView: View {
    @StateObject var viewModel = MovieRankViewModel()

    var body: some View {
        Group {
            List(viewModel.boxOfficeList, id: \.rank) { movie in
                NavigationLink(destination: MovieDetailView(boxOfficeMovie: movie, rankViewModel: viewModel)) {
                    MovieRankRowView(viewModel: viewModel, movie: movie)
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            DispatchQueue.main.async {
                viewModel.fetchMovie()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankView()
    }
}
