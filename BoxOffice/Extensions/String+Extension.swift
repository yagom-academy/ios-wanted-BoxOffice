//
//  String+Extension.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/21.
//

import Foundation

extension String {
    enum emoji: String {
        case boxOfficeRank = "🍿 박스오피스 랭크"
        case movieName = "🎥 영화이름"
        case releasedDay = "📣 개봉일"
        case audCount = "🕶 관객수"
        case rankIncrement = "🧮 랭크증감"
        case rankApproach = "🎖 랭크신규진입"
        case makedYear = "📆 제작년도"
        case releasedYear = "📅 개봉년도"
        case runningTime = "⌛️ 상영시간"
        case genres = "📚 장르"
        case directors = "🎬 감독"
        case actors = "🎭 배우"
        case restrictionRate = "⛔️ 관람등급"
    }
    
    static func emojiAndTitle(emojiValue: emoji) -> Self {
        return emojiValue.rawValue
    }
    
    func koficDateToYear() -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: self) else { return nil }
        
        let yearFormatter = DateFormatter()
        yearFormatter.locale = Locale(identifier: "ko")
        yearFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        yearFormatter.dateFormat = "yyyy"
        return yearFormatter.string(from: date)
    }
}


