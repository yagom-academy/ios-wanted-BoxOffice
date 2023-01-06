import Foundation

struct BoxOffice: Decodable {
    /// 순번
    let number: Int
    /// 해당일자의 박스오피스 순위
    let rank: Int
    /// 전일대비 순위의 증감분
    let rankInten: Int
    /// 랭킹에 신규진입여부
    let isNewRanked: Bool
    /// 영화의 대표코드
    let movieCD: String
    /// 영화명(국문)
    let movieNm: String
    /// 영화의 개봉일
    let openDate: Date
    /// 해당일의 매출액
    let salesAmt: Int
    /// 해당일자 상영작의 매출총액 대비 해당 영화의 매출비율
    let salesShare: Double
    /// 전일 대비 매출액 증감분
    let salesInten: Int
    /// 전일 대비 매출액 증감 비율
    let salesChange: Int
    /// 누적매출액
    let salesAcc: Int
    /// 해당일의 관객수
    let audiCnt: Int
    /// 전일 대비 관객수 증감분
    let audiInten: Int
    /// 전일 대비 관객수 증감 비율
    let audiChange: Int
    /// 누적관객수
    let audiAcc: Int
    /// 해당일자에 상영한 스크린수
    let scrnCnt: Int
    /// 해당일자에 상영된 횟수
    let showCnt: Int

    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank, rankInten
        case isNewRanked = "rankOldAndNew"
        case movieCD = "movieCd"
        case movieNm
        case openDate = "openDt"
        case salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .openDate)

        self.number = Int(try container.decode(String.self, forKey: .number)) ?? 0
        self.rank = Int(try container.decode(String.self, forKey: .rank)) ?? 0
        self.rankInten = Int(try container.decode(String.self, forKey: .rankInten)) ?? 0
        let rankOldAndNew = try container.decode(RankOldAndNew.self, forKey: .isNewRanked)
        self.isNewRanked = rankOldAndNew == .new ? true : false
        self.movieCD = try container.decode(String.self, forKey: .movieCD)
        self.movieNm = try container.decode(String.self, forKey: .movieNm)
        self.openDate = try Self.decodeDate(date: dateString)
        self.salesAmt = Int(try container.decode(String.self, forKey: .salesAmt)) ?? 0
        self.salesShare = Double(try container.decode(String.self, forKey: .salesShare)) ?? 0
        self.salesInten = Int(try container.decode(String.self, forKey: .salesInten)) ?? 0
        self.salesChange = Int(try container.decode(String.self, forKey: .salesChange)) ?? 0
        self.salesAcc = Int(try container.decode(String.self, forKey: .salesAcc)) ?? 0
        self.audiCnt = Int(try container.decode(String.self, forKey: .audiCnt)) ?? 0
        self.audiInten = Int(try container.decode(String.self, forKey: .audiInten)) ?? 0
        self.audiChange = Int(try container.decode(String.self, forKey: .audiChange)) ?? 0
        self.audiAcc = Int(try container.decode(String.self, forKey: .audiAcc)) ?? 0
        self.scrnCnt = Int(try container.decode(String.self, forKey: .scrnCnt)) ?? 0
        self.showCnt = Int(try container.decode(String.self, forKey: .showCnt)) ?? 0
    }

    private static func decodeDate(date input: String) throws -> Date {
        let dateFommater = ISO8601DateFormatter()
        dateFommater.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFommater.formatOptions = .withFullDate

        guard let date = dateFommater.date(from: input) else {
            throw DecodeError.dateDecodeFail(from: input)
        }
        return date
    }

    private enum RankOldAndNew: String, Decodable {
        case new = "NEW"
        case old = "OLD"
    }
}
