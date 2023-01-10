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
                if dailyBoxOfficeList.rankInten.convertInt == 0 {
                    Image(systemName: "minus")
                        .foregroundColor(.orange)
                } else if dailyBoxOfficeList.rankInten.convertInt > 0 {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.red)
                } else if dailyBoxOfficeList.rankInten.convertInt < 0 {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.blue)
                }
                
                VStack {
                    Text(dailyBoxOfficeList.rank + ". " + dailyBoxOfficeList.movieNm)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                        .lineLimit(1)
                    HStack {
                        Text("개봉일 " + dailyBoxOfficeList.openDt.dateYearFormatter.translateToYearString())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("누적 관객수 " + dailyBoxOfficeList.audiAcc.insertComma)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.top, 5)
                }
            }
        }
        .foregroundColor(.primary)
        .font(.caption)
        .padding()
    }
}
