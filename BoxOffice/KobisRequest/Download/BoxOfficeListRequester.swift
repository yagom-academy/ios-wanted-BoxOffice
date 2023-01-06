import Foundation

struct BoxOfficeListRequester {
    func requestDailyList(_ params: BoxOfficeListRequest, completionHandler: @escaping (Result<KobisResult, Error>) -> Void ){
        guard let url = params.dailyBoxOfficeListUrl else { return }
        request(url, completionHandler: completionHandler)
    }

    func requestWeeklyList(_ params: BoxOfficeListRequest, completionHandler: @escaping (Result<KobisResult, Error>) -> Void) {
        guard let url = params.weeklyBoxOfficeListUrl else { return }
        request(url, completionHandler: completionHandler)
    }

    private func request(_ url: URL, completionHandler: @escaping (Result<KobisResult, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let decodeHandler: (Result<Data, Error>) -> Void = { requestResult in
            let result: Result<KobisResult, Error>
            switch requestResult {
            case .failure(let error):
                result = .failure(error)
            case .success(let jsonData):
                do {
                    let kobisResult = try JSONDecoder().decode(KobisResult.self, from: jsonData)
                    result = .success(kobisResult)
                } catch {
                    result = .failure(error)
                }
            }
            completionHandler(result)
        }

        let task = dataTask(from: request, completionHandler: decodeHandler)
        task.resume()
    }

    private func dataTask(
        from request: URLRequest,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(DecodeError.httpResponse(response)))
                return
            }
            guard let data = data else { return }
            completionHandler(.success(data))
        }
        return dataTask
    }

    struct BoxOfficeListRequest {
        enum WeekGb: String {
            case week = "0"
            case weekend = "1"
            case weekdays = "2"
        }

        private let apiHost = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice"
        private let apiKey: String = "e654b63663c57dea1f3ed2abb4fae5d2"
        let targetDt: Date
        var weekGb: WeekGb? = nil
        var itemPerPage: Int? = nil
        var multiMovieYn: String? = nil
        var repNationCd: String? = nil
        var wideAreaCd: String? = "0105001"

        var dailyBoxOfficeListUrl: URL? {
            var urlComponents = URLComponents(string: "\(apiHost)/searchDailyBoxOfficeList.json")
            urlComponents?.queryItems = queryItems
            return urlComponents?.url
        }

        var weeklyBoxOfficeListUrl: URL? {
            var urlComponents = URLComponents(string: "\(apiHost)/searchWeeklyBoxOfficeList.json")
            urlComponents?.queryItems = queryItems
            if let weekGb = weekGb {
                urlComponents?.queryItems?.append(URLQueryItem(name: "weekGb", value: weekGb.rawValue))
            }
            return urlComponents?.url
        }

        private var queryItems: [URLQueryItem] {
            let dateFommater = DateFormatter()
            dateFommater.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFommater.timeStyle = .none
            dateFommater.dateFormat = "yyyyMMdd"
            let dateString = dateFommater.string(from: targetDt)

            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "key", value: apiKey))
            queryItems.append(URLQueryItem(name: "targetDt", value: dateString))
            if let wideAreaCd = wideAreaCd {
                queryItems.append(URLQueryItem(name: "wideAreaCd", value: wideAreaCd))
            }
            if let itemPerPage = itemPerPage {
                queryItems.append(URLQueryItem(name: "itemPerPage", value: String(itemPerPage)))
            }
            if let multiMovieYn = multiMovieYn {
                queryItems.append(URLQueryItem(name: "multiMovieYn", value: multiMovieYn))
            }
            if let repNationCd = repNationCd {
                queryItems.append(URLQueryItem(name: "repNationCd", value: repNationCd))
            }

            return queryItems
        }
    }
}

