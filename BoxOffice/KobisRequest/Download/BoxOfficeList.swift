import Foundation

struct BoxOfficeList: Decodable {
    let boxofficeType: BoxOfficeType
    let showRange: DateInterval
    let yearWeekTime: Date?
    let movies: [BoxOffice]

    enum CodingKeys: CodingKey {
        case boxofficeType
        case showRange
        case yearWeekTime
        case dailyBoxOfficeList
        case weeklyBoxOfficeList
    }
}

extension BoxOfficeList {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.boxofficeType = try container.decode(BoxOfficeType.self, forKey: .boxofficeType)

        let showRangeString = try container.decode(String.self, forKey: .showRange)
        self.showRange = try Self.decodeShowRange(dates: showRangeString)

        if let yearWeekString = try container.decodeIfPresent(String.self, forKey: .yearWeekTime) {
            self.yearWeekTime = try Self.decodeYearWeekTime(date: yearWeekString)
        } else {
            self.yearWeekTime = nil
        }

        if let dailyList = try container.decodeIfPresent([BoxOffice].self, forKey: .dailyBoxOfficeList) {
            self.movies = dailyList
        } else if let weeklyList = try container.decodeIfPresent([BoxOffice].self, forKey: .weeklyBoxOfficeList) {
            self.movies = weeklyList
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.weeklyBoxOfficeList,
                DecodingError.Context(
                    codingPath: [CodingKeys.dailyBoxOfficeList, CodingKeys.weeklyBoxOfficeList],
                    debugDescription: "dailyBoxOfficeList or weeklyBoxOfficeList not found"
                )
            )
        }
    }

    private static func decodeShowRange(dates input: String) throws -> DateInterval {
        let dates = input.split(separator: "~")
        let start = String(dates[safe: 0] ?? "")
        let end = String(dates[safe: 1] ?? "")

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyyMMdd"

        guard let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: end) else {
            throw DecodeError.dateIntervalDecodeFail(from: input)
        }
        let result = DateInterval(start: startDate, end: endDate)
        return result
    }

    private static func decodeYearWeekTime(date input: String) throws -> Date {
        let dateFommater = ISO8601DateFormatter()
        dateFommater.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFommater.formatOptions = [.withYear, .withWeekOfYear]

        var inputString = input
        let index = inputString.index(inputString.startIndex, offsetBy: 3)
        inputString.insert(Character("W"), at: index)
        guard let date = dateFommater.date(from: inputString) else {
            throw DecodeError.yearWeekTimeDecodeFail(from: input)
        }
        return date
    }
}

