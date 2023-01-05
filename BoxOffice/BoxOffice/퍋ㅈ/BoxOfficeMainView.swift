//
//  BoxOfficeMainView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/03.
//

import SwiftUI

struct BoxOfficeMainView: View {
    
    @StateObject var boxOfficeMainViewModel = BoxOfficeMainViewModel()
    @StateObject private var imageLoader = URLImageLoader()

    var body: some View {
        NavigationView {
            if boxOfficeMainViewModel.url.count != 0 {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Top3")
                                .font(.headline)
                                .padding(.leading, 15)
                                .padding(.top, 5)
                            TabView {
                                ForEach(0..<3, id: \.self) { index in
                                    NavigationLink {
                                        BoxOfficeDetailView(
                                            viewModel: boxOfficeMainViewModel,
                                            myIndex: index
                                        )
                                    } label: {
                                        ZStack(alignment: .bottomLeading) {
                                            Image(uiImage: boxOfficeMainViewModel.url[index])
                                                .resizable()
                                                .renderingMode(.original)
                                            Text("\(index + 1)")
                                                .padding(10)
                                                .font(.largeTitle)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            .frame(height: 200)
                            .cornerRadius(10)
                            .tabViewStyle(PageTabViewStyle())
                        }
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            Text("예매 순위 Top10")
                                .font(.headline)
                                .padding(.leading, 15)
                                .padding(.top, 5)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(Array(boxOfficeMainViewModel.movieList.enumerated()), id: \.0) { index, data in
                                        NavigationLink {
                                            BoxOfficeDetailView(
                                                viewModel: boxOfficeMainViewModel,
                                                myIndex: index
                                            )
                                        } label: {
                                            ZStack(alignment: .bottomLeading) {
                                                Image(uiImage: boxOfficeMainViewModel.url[index])
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .frame(width: 200, height: 200)
                                                    .cornerRadius(10)
                                                Text(data.rank + ". " + data.movieNm)
                                                    .padding(10)
                                                    .lineLimit(1)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15, weight: .bold))
                                            }
                                            .frame(width: 200)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Section {
                        VStack(alignment: .leading) {
                            Text("상영 영화 정보")
                                .font(.headline)
                                .padding(.leading, 15)
                                .padding(.top, 5)
                            ScrollView {
                                ForEach(Array(boxOfficeMainViewModel.movieList.enumerated()), id: \.0) { index, data in
                                    NavigationLink {
                                        BoxOfficeDetailView(
                                            viewModel: boxOfficeMainViewModel,
                                            myIndex: index
                                        )
                                    } label: {
                                        BoxOfficeListView(dailyBoxOfficeList: data)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("BoxOffice")
                .navigationBarTitleDisplayMode(.large)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            boxOfficeMainViewModel.fetchDailyBoxOfficeList(
                dateType: .daily,
                targetDate: boxOfficeMainViewModel.getYesterdayDate()
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeMainView()
    }
}
