struct KobisResult: Decodable {
    let boxOfficeList: BoxOfficeList

    enum CodingKeys: String, CodingKey {
        case boxOfficeList = "boxOfficeResult"
    }
}
