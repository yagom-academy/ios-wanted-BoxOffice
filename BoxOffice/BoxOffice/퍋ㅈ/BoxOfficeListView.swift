//
//  BoxOfficeListView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI

struct BoxOfficeListView: View {

    var dailyBoxOfficeList: DailyBoxOfficeList
    
    var body: some View {
        VStack {
            HStack {
                Text(dailyBoxOfficeList.rank + ". " + dailyBoxOfficeList.movieNm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if dailyBoxOfficeList.rankOldAndNew == RankOldAndNew.old {
                    Text(dailyBoxOfficeList.rankOldAndNew.rawValue)
                        .foregroundColor(.secondary)
                } else {
                    Text(dailyBoxOfficeList.rankOldAndNew.rawValue)
                        .foregroundColor(.red)
                }
            }
            .font(.body)
            .lineLimit(1)
            
            HStack {
                Text("전일 증감분 " + dailyBoxOfficeList.rankInten)
                Text("|")
                Text("누적 관객수 " + dailyBoxOfficeList.audiCnt.insertComma)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundColor(.primary)
        .font(.caption)
        .padding()
    }
}
