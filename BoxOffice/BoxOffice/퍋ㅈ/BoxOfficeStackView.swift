//
//  BoxOfficeStackView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI

struct BoxOfficeStackView: View {
    
    @StateObject private var imageLoader = URLImageLoader()

    var dailyModel: BoxOfficeMainViewModel
    var dailyBoxOfficeList: DailyBoxOfficeList
    var myIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            }
            HStack {
                Text(dailyBoxOfficeList.rank + ". " + dailyBoxOfficeList.movieNm)
            }
            .padding(10)
            .lineLimit(1)
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .bold))
        }
        .frame(width: 200)
        .onAppear {
            imageLoader.fetch(urlString: dailyModel.url[myIndex])
        }
    }
}
