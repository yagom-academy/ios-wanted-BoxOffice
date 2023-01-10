//
//  MovieRankTapView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieRankTapView: View {

    enum Tab: String {
        case daily = "일간"
        case weekly = "주간"
        case weekend = "주말"
    }

    @State private var selection: Tab = .daily

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                MovieRankView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage(systemName: "sun.min") ?? UIImage())
                            Text("일간")
                        }
                    }
                    .tag(Tab.daily)
                MovieRankView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage(systemName: "desktopcomputer") ?? UIImage())
                            Text("주간")
                        }
                    }
                    .tag(Tab.weekly)
                MovieRankView()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage(systemName: "person.3") ?? UIImage())
                            Text("주말")
                        }
                    }
                    .tag(Tab.weekend)
            }
            .navigationTitle("\(selection.rawValue)" + " 박스오피스 순위")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieRankTapView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRankTapView()
    }
}
