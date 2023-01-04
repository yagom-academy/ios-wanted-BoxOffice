//
//  BoxOfficeMainView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/03.
//

import SwiftUI

struct BoxOfficeMainView: View {
    
    @ObservedObject var boxOfficeMainViewModel = BoxOfficeMainViewModel()
    
    var body: some View {
        NavigationView {
            if boxOfficeMainViewModel.movieList.count != 0 {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Top3")
                                .font(.headline)
                                .padding(.leading, 15)
                                .padding(.top, 5)
                            TabView {
                                ForEach(Array(boxOfficeMainViewModel.movieList.enumerated()), id: \.0) { index, data in
                                    NavigationLink {
                                        BoxOfficeDetailView(
                                            viewModel: boxOfficeMainViewModel,
                                            myIndex: index
                                        )
                                    } label: {
                                        BoxOfficeTabView(
                                            viewModel: boxOfficeMainViewModel,
                                            myIndex: index)
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
                                            BoxOfficeStackView(
                                                dailyModel: boxOfficeMainViewModel,
                                                dailyBoxOfficeList: data,
                                                myIndex: index
                                            )
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
