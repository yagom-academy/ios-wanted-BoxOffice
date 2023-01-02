//
//  MovieRankRowView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankRowView: View {
    var movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Image(uiImage: UIImage(named: "Avatar")!)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(maxWidth: geometry.size.width)
            }
            HStack() {
                Text(movie.rank)
                    .font(.headline)
                Text(movie.rankOldAndNew)
                Text(movie.rankInten)
                VStack(alignment: .leading) {
                    Text(movie.movieName)
                        .font(.headline)
                    HStack {
                        Text(movie.openDtDay)
                        Text(movie.spectators)
                    }
                    .font(.subheadline)
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

struct MovieRankRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankRowView(movie: Movie(rank: "1", movieName: "아바타", openDtDay: "2022/12/15", spectators: "10000000", rankInten: "0", rankOldAndNew: "Old", prdtYear: "2022", openDtYear: "2022", showTm: "3시간", genreNm: "판타지", directorNm: "제임스카메룬", actorNm: "나비족", watchGradeNm: "15세"))
    }
}
