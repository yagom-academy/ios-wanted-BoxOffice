//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/02.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isPresented = false
    var movie: Movie

    var body: some View {
        List {
            Section(footer: HStack {
                Button(action: {
                    isPresented = true
                }, label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 170, height: 40)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("🖋️ 리뷰 등록하기")
                            .foregroundColor(.white)
                    }
                })
                .sheet(isPresented: $isPresented) {
                    MovieReviewPostView()
                }
                Button(action: {
                    let sharePoster = UIImage(named: "Avatar")
                    let shareInformation = """
                                            영화명: \(movie.movieName)
                                            박스오피스 순위: \(movie.rank)
                                            개봉일: \(movie.openDtDay)
                                            관객수: \(movie.spectators)
                                            전일대비 순위: \(movie.rankInten)
                                            랭킹에 신규진입 여부: \(movie.rankOldAndNew)
                                            제작연도: \(movie.prdtYear)
                                            개봉연도: \(movie.openDtYear)
                                            상영시간: \(movie.showTm)
                                            장르: \(movie.genreNm)
                                            감독명: \(movie.directorNm)
                                            배우명: \(movie.actorNm)
                                            관람등급: \(movie.watchGradeNm)
                                            리뷰 별점 평균: 4.4
                                            리뷰리스트:?
                                            """
                    let activityVC = UIActivityViewController(activityItems: [sharePoster as Any ,shareInformation], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController!.present(activityVC, animated: true, completion: nil)
                }, label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 170, height: 40)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("공유하기")
                            .foregroundColor(.white)
                    }
                })
            }) {
                HStack(alignment: .top) {
                    Image(uiImage: UIImage(named: "Avatar")!)
                        .resizable()
                        .aspectRatio(450/650, contentMode: .fit)
                    MovieInformationView(movie: movie)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .frame(width: 4, height: 20)
                            .foregroundColor(.red)
                        Text("박스오피스 순위")
                            .bold()
                            .font(.title3)
                    }
                    HStack {
                        Text("현재 순위:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text("\(movie.rank) 위")
                            .bold()
                    }
                    HStack {
                        Text("전일 대비:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        if Int(movie.rankInten) == 0 {
                            Rectangle()
                                .frame(width: 13, height: 2)
                        } else if Int(movie.rankInten) ?? 0 > 0 {
                            HStack(spacing: 2) {
                                Text("↑")
                                    .foregroundColor(.red)
                                    .bold()
                                Text(movie.rankInten)
                            }
                        } else {
                            HStack(spacing: 2) {
                                Text("↓")
                                    .foregroundColor(.blue)
                                    .bold()
                                Text(movie.rankInten)
                            }
                        }
                    }
                    HStack {
                        Text("현재 순위:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text("\(movie.rank) 위")
                            .bold()
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .frame(width: 4, height: 20)
                            .foregroundColor(.red)
                        Text("제작 정보")
                            .bold()
                            .font(.title3)
                    }
                    HStack {
                        Text("제작 연도:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text(movie.prdtYear)
                            .bold()
                    }
                    HStack {
                        Text("개봉 연도:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text(movie.openDtYear)
                            .bold()
                    }
                }
            }
        }
        .navigationTitle(movie.movieName)
        .frame(alignment: .center)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("❮" + " \(movie.movieName)", action: {
            presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct MovieInformationView: View {
    var movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("영화명:")
                    .bold()
                Text("\(movie.movieName)")
                    .bold()
            }
            .font(.title3)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("개봉일:")
                    .bold()
                Text("\(movie.openDtDay)")
            }
            HStack {
                Text("관객수:")
                    .bold()
                Text("\(movie.spectators)")
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("장르:")
                    .bold()
                Text("\(movie.genreNm)")
            }
            HStack {
                Text("관람등급:")
                    .bold()
                Text("\(movie.watchGradeNm)")
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("상영시간:")
                    .bold()
                Text("\(movie.showTm)")
            }
            HStack {
                Text("감독:")
                    .bold()
                Text("\(movie.directorNm)")
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(rank: "1", movieName: "아바타", openDtDay: "2022/12/15", spectators: "10000000", rankInten: "0", rankOldAndNew: "Old", prdtYear: "2021", openDtYear: "2022", showTm: "3시간", genreNm: "판타지", directorNm: "제임스카메룬", actorNm: "나비족", watchGradeNm: "15세"))
    }
}
