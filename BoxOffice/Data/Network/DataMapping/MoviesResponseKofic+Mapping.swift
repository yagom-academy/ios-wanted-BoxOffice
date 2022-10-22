//
//  MoviesResponseKofic+Mapping.swift
//  BoxOffice
//
//  Created by channy on 2022/10/20.
//

import Foundation

/*
 "rnum":"1",
 "rank":"1",
 "rankInten":"0",
 "rankOldAndNew":"OLD",
 "movieCd":"20112207",
 "movieNm":"미션임파서블:고스트프로토콜",
 "openDt":"2011-12-15",
 "salesAmt":"2776060500",
 "salesShare":"36.3",
 "salesInten":"-415699000",
 "salesChange":"-13",
 "salesAcc":"40541108500",
 "audiCnt":"353274",
 "audiInten":"-60106",
 "audiChange":"-14.5",
 "audiAcc":"5328435",
 "scrnCnt":"697",
 "showCnt":"3223"
 */

/*
 "Title":"Eternals",
 "Year":"2021",
 "Rated":"PG-13",
 "Released":"05 Nov 2021",
 "Runtime":"156 min",
 "Genre":"Action, Adventure, Fantasy",
 "Director":"Chloé Zhao",
 "Writer":"Chloé Zhao, Patrick Burleigh, Ryan Firpo",
 "Actors":"Gemma Chan, Richard Madden, Angelina Jolie",
 "Plot":"Following the events of Avengers: Endgame (2019), an unexpected tragedy forces the Eternals, ancient aliens who have been living on Earth in secret for thousands of years, out of the shadows to reunite against mankind's most ancient enemy, the Deviants.",
 "Language":"English, American Sign , Marathi, Spanish, Sumerian, Latin, Greek, Ancient (to 1453)",
 "Country":"United States",
 "Awards":"7 wins & 16 nominations",
 "Poster":"https://m.media-amazon.com/images/M/MV5BY2Y1ODBhYTItYmJiZi00NjU2LWI2NjktNTcwM2U2NGQ2ZTNiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg",
 "Ratings":[{"Source":"Internet Movie Database","Value":"6.3/10"},{"Source":"Rotten Tomatoes","Value":"47%"},{"Source":"Metacritic","Value":"52/100"}],
 "Metascore":"52",
 "imdbRating":"6.3",
 "imdbVotes":"331,763",
 "imdbID":"tt9032400",
 "Type":"movie",
 "DVD":"12 Jan 2022",
 "BoxOffice":"$164,870,234",
 "Production":"N/A",
 "Website":"N/A",
 "Response":"True"
 */

/*
 박스오피스 순위
 영화명
 개봉일
 관객수
 전일대비 순위의 증감분
 랭킹에 신규 진입 여부
 */

struct MoviesResponseKoficList: Decodable {
    let boxOfficeResult: MoviesReponseKoficSubList
}

struct MoviesReponseKoficSubList: Decodable {
    let boxofficeType: String
    let dailyBoxOfficeList: [MoviesResponseKofic]
}

struct MoviesResponseKofic: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
}

extension MoviesResponseKofic {
    func toDomain() -> Movie {
        return .init(rank: rank, movieNm: movieNm, openDt: openDt, audiAcc: audiAcc, rankInten: rankInten, rankOldAndNew: rankOldAndNew, movieCd: movieCd)
    }
}
