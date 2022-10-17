//
//  APIService.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

final class ApiService {
    
    func getRequestData(type: ListType) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/"
        let key = "12429f4fc25fcfcef21b71215d8dabc1"
        let targetDt = Date().dateString
        let wideAreaCd = "0105001"  // 서울코드
        
        let urlString = "\(url)search\(type.rawValue)BoxOfficeList.json?key=\(key)&targetDt=\(targetDt)&wideAreaCd=\(wideAreaCd)"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode.isSuccessCode {
                // TODO: data decording
                print(#function, data)
            }
        }.resume()
    }
}
