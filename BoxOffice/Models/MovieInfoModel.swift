//
//  MovieInfoModel.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/18.
//

struct MovieInfoModel: Codable {
//    let movieCd: String   // 문자열    영화코드를 출력합니다.
    var movieNm: String   // 문자열    영화명(국문)을 출력합니다.
    var movieNmEn: String   // 문자열    영화명(영문)을 출력합니다.
    var movieNmOg: String   // 문자열    영화명(원문)을 출력합니다.
    var prdtYear: String   // 문자열    제작연도를 출력합니다.
    var showTm: String   // 문자열    상영시간을 출력합니다.
//    let showTypes: [ShowType]   // 문자열    상영형태 구분을 나타냅니다.
    var openDt: String   // 문자열    개봉연도를 출력합니다.
//    let prdtStatNm: String   // 문자열    제작상태명을 출력합니다.
//    let typeNm: String   // 문자열    영화유형명을 출력합니다.
    var nations: [Nation]   // 문자열    제작국가를 나타냅니다.
    var genres: [Genres]   // 문자열    장르명을 출력합니다.
    var directors: [Director]   // 문자열    감독을 나타냅니다.
    var actors: [Actor]   // 문자열    배우를 나타냅니다.
    var audits: [Audit]   // 문자열    심의정보를 나타냅니다.
    var dailyBoxOfficeInfo: BoxOfficeModel?
//    let companys: [Company]   // 문자열    참여 영화사를 나타냅니다.
//    let staffs: [Staff]   // 문자열    스텝을 나타냅니다.
    
}

struct ShowType: Codable {
    let showTypeGroupNm: String   // 문자열    상영형태 구분을 출력합니다.
    let showTypeNm: String   // 문자열    상영형태명을 출력합니다.
}

struct Company: Codable {
    let companyCd: String   // 문자열    참여 영화사 코드를 출력합니다.
    let companyNm: String   // 문자열    참여 영화사명을 출력합니다.
    let companyNmEn: String   // 문자열    참여 영화사명(영문)을 출력합니다.
    let companyPartNm: String   // 문자열    참여 영화사 분야명을 출력합니다.
}

struct Audit: Codable {
    let auditNo: String   // 문자열    심의번호를 출력합니다.
    let watchGradeNm: String   // 문자열    관람등급 명칭을 출력합니다.
}

struct Nation: Codable {
    let nationNm: String   // 문자열    제작국가명을 출력합니다.
}

struct Genres: Codable {
    let genreNm: String
}

struct Actor: Codable {
    let peopleNm: String   // 문자열    배우명을 출력합니다.
    let peopleNmEn: String   // 문자열    배우명(영문)을 출력합니다.
    let cast: String   // 문자열    배역명을 출력합니다.
    let castEn: String   // 문자열    배역명(영문)을 출력합니다.
}

struct Director: Codable {
    let peopleNm: String   // 문자열    감독명을 출력합니다.
    let peopleNmEn: String   // 문자열    감독명(영문)을 출력합니다.
}

struct Staff: Codable {
    let peopleNm: String   // 문자열    스텝명을 출력합니다.
    let peopleNmEn: String   // 문자열    스텝명(영문)을 출력합니다.
    let staffRoleNm: String   // 문자열    스텝역할명을 출력합니다.
}


struct MovieInfoResultModel: Codable {
    var movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    var movieInfo: MovieInfoModel
    var source: String
}
