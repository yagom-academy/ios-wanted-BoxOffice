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
    
    enum SearchOption: String {
        case daily = "searchDailyBoxOfficeList"
        case weekly = "searchWeeklyBoxOfficeList"
    }
    
    enum WeeklySearchFilter: Int {
        case weekly = 0
        case weekend = 1 // default
        case weekdays = 2
    }
    
    static let shared = RequestManager()
    private init () { }
     
    private let PER_PAGE = 10 // max 10
    var items: [BoxOfficeModel] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updated_item"), object: nil)
        }
    }
    
    func getDailyBoxOffice(_ date: Date = Date(), _ completion: @escaping ([BoxOfficeModel]) -> Void) {
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
                
                completion(result.boxOfficeResult.dailyBoxOfficeList!)
            } catch {
                completion([])
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getWeeklyBoxOffice(_ date: Date = Date(), weekGb: WeeklySearchFilter = .weekend, _ completion: @escaping ([BoxOfficeModel]) -> Void) {
        let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
        let targetDate = getDateForWeekly(date: date)
        guard let url = URL(string: "\(baseUrl)?key=\(Bundle.main.apikey)&targetDt=\(targetDate)&weekGb=\(weekGb.rawValue)") else {
            print("Can not create url.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(BoxOfficeResultRoot.self, from: data!)
                
                completion(result.boxOfficeResult.weeklyBoxOfficeList!)
            } catch {
                completion([])
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getDateForDaily(date: Date) -> String {
        let calendar = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let year = calendar.year!
        let month = calendar.month!
        let day = calendar.day! - 1
        return "\(year)\(month)\(day)"
    }
    
    func getDateForWeekly(date: Date) -> String {
        let calendar = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: date)
        let year = calendar.year!
        let month = calendar.month!
        let day = calendar.day! - calendar.weekday!
        return "\(year)\(month)\(day)"
    }
    
    func getMovieInfo(movieCd: String = "20124079", _ completion: @escaping (MovieInfoModel) -> Void) {
        let baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        guard let url = URL(string: "\(baseUrl)?key=\(Bundle.main.apikey)&movieCd=\(movieCd)") else {
            print("Can not create url.")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MovieInfoResultModel.self, from: data!)
                completion(result.movieInfoResult.movieInfo)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
