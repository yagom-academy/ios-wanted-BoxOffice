//
//  MovieRankTapView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankTapView: View {
    var body: some View {
        TabView {
            MovieRankView(title: "일간")
                .tabItem {
                    Text("일간")
                }
            MovieRankView(title: "주간")
                .tabItem {
                    Text("주간")
                }
            MovieRankView(title: "주말")
                .tabItem {
                    Text("주말")
                }
        }
    }
}

struct MovieRankTapView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankTapView()
    }
}
