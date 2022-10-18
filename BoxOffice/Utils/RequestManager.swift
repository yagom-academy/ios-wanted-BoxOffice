//
//  RequestManager.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/17.
//

import Foundation

class RequestManager {
    
    enum CustomError: Error {
        case error
    }
    
    static let shared = RequestManager()
    private init () { }
     
    private let PER_PAGE = 10 // max 10
    var items: [BoxOfficeModel] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updated_item"), object: nil)
        }
    }
    
//    func getBoxOffice(_ date: Date = Date()) async throws {
//        let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
//        let targetDate = getDateForDaily(date: date)
//        guard let url = URL(string: "\(baseUrl)?key=\(Bundle.main.apikey)&targetDt=\(targetDate)&itemPerPage=\(PER_PAGE)") else {
//            print("Can not create url.")
//            throw CustomError.error
//        }
//        
//        let (data, httpResponse) = try await URLSession.shared.data(from: url)
//        
//        guard let response = httpResponse as? HTTPURLResponse, response.statusCode == 200 else {
//            throw CustomError.error
//        }
//        
//        let decoder = JSONDecoder()
//        let result = try decoder.decode(BoxOfficeResultRoot.self, from: data)
//        
//        var boxOfficeViewModels = [BoxOfficeViewModel]()
//        result.boxOfficeResult.dailyBoxOfficeList.forEach {
//            boxOfficeViewModels.append(BoxOfficeViewModel(boxOffice: $0))
//        }
//        items = boxOfficeViewModels
//    }
    
    func fetch(_ date: Date = Date(), _ completion: @escaping ([BoxOfficeModel]) -> Void) {
        let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let targetDate = getDateForDaily(date: date)
        guard let url = URL(string: "\(baseUrl)?key=\(Bundle.main.apikey)&targetDt=\(targetDate)&itemPerPage=\(PER_PAGE)") else {
            print("Can not create url.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(BoxOfficeResultRoot.self, from: data!)
                
                completion(result.boxOfficeResult.dailyBoxOfficeList)
            } catch {
                completion([])
                print(error.localizedDescription)
            }
        }
    }
    
    func getDateForDaily(date: Date) -> String {
        let calendar = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = calendar.year!
        let month = calendar.month!
        let day = calendar.day! - 1
        return "\(year)\(month)\(day)"
    }
    
    func fetch(movieCd: String = "20124079") {
        let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        guard let url = URL(string: "\(baseUrl)?key=\(Bundle.main.apikey)&movieCd=\(movieCd)") else {
            print("Can not create url.")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MovieInfoResultModel.self, from: data!)
                
                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
