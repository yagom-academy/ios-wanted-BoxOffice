//
//  ContentView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct Movie: Hashable {
    let rank: String
    let movieName: String
    let openDtDay: String
    let spectators: String
    let rankInten : String
    let rankOldAndNew : String
    let prdtYear : String
    let openDtYear: String
    let showTm : String
    let genreNm : String
    let directorNm : String
    let actorNm : String
    let watchGradeNm : String
}

struct MovieList {
    let List: [Movie]

    init(List: [Movie]) {
        self.List = List
    }
}

struct MovieRankView: View {
    var movieList: [Movie] = [Movie(rank: "1", movieName: "아바타", openDtDay: "2022/12/15", spectators: "10000000", rankInten: "0", rankOldAndNew: "Old", prdtYear: "2022", openDtYear: "2022", showTm: "3시간", genreNm: "판타지", directorNm: "제임스카메룬", actorNm: "나비족", watchGradeNm: "15세"), Movie(rank: "1", movieName: "아바타", openDtDay: "2022/12/15", spectators: "10000000", rankInten: "0", rankOldAndNew: "Old", prdtYear: "2022", openDtYear: "2022", showTm: "3시간", genreNm: "판타지", directorNm: "제임스카메룬", actorNm: "나비족", watchGradeNm: "15세"), Movie(rank: "1", movieName: "아바타", openDtDay: "2022/12/15", spectators: "10000000", rankInten: "0", rankOldAndNew: "Old", prdtYear: "2022", openDtYear: "2022", showTm: "3시간", genreNm: "판타지", directorNm: "제임스카메룬", actorNm: "나비족", watchGradeNm: "15세")]

    var body: some View {
        NavigationView {
            Group {
                List(movieList, id: \.self) { movie in
                    MovieRankRowView(movie: movie)
                }
                .listStyle(.automatic)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankView()
    }
}
