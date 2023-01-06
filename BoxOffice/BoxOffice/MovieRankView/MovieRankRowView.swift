//
//  MovieRankRowView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankRowView: View {
    @ObservedObject var viewModel: MovieRankViewModel
    let movie: BoxOfficeMovie

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Image(uiImage:  viewModel.posters[(Int(movie.rank) ?? 0) - 1])
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(maxWidth: geometry.size.width)
            }
            HStack() {
                Text(movie.rank)
                    .font(.largeTitle)
                Text(movie.isNewRanked)
                    .font(.caption)
                if Int(movie.rankIncrease) == 0 {
                    Rectangle()
                        .frame(width: 13, height: 2)
                } else if Int(movie.rankIncrease) ?? 0 > 0 {
                    HStack(spacing: 2) {
                        Text("↑")
                            .foregroundColor(.red)
                            .bold()
                        Text(movie.rankIncrease)
                    }
                } else {
                    HStack(spacing: 2) {
                        Text("↓")
                            .foregroundColor(.blue)
                            .bold()
                        Text(movie.rankIncrease)
                    }
                }
                VStack(alignment: .leading) {
                    Text(movie.movieName)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                    Text("개봉일: " + movie.openDate)
                        .font(.caption)
                    Text("총 관람객 수: " + movie.audienceAttendance.numberOfPeople + "명")
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .foregroundColor(Color.white)
            .lineLimit(1)
            .background(Rectangle()
                .foregroundColor(Color.black)
                .opacity(0.6)
                .blur(radius: 2.5))
        }
        .frame(height: 300)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

    }
}
