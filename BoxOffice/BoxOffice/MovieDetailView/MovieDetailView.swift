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
    @ObservedObject var viewModel = MovieDetailViewModel()
    @Binding var poster: UIImage
    var boxOfficeMovie: BoxOfficeMovie

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
                .fullScreenCover(isPresented: $isPresented) {
                    MovieReviewPostView(isPresented: $isPresented)
                }

                Button(action: {
                    let sharePoster = poster
                    let shareInformation = """
                                            영화명: \(boxOfficeMovie.movieName)
                                            박스오피스 순위: \(boxOfficeMovie.rank)
                                            개봉일: \(boxOfficeMovie.openDate)
                                            관객수: \(boxOfficeMovie.audienceAttendance)
                                            전일대비 순위: \(boxOfficeMovie.rankIncrease)
                                            랭킹에 신규진입 여부: \(boxOfficeMovie.isNewRanked)
                                            제작연도: \(viewModel.detailInformation.productionYear)
                                            개봉연도: \(viewModel.detailInformation.openDate)
                                            상영시간: \(viewModel.detailInformation.showTime)
                                            장르: \(viewModel.detailInformation.genres)
                                            감독명: \(viewModel.detailInformation.directors)
                                            배우명: \(viewModel.detailInformation.actors)
                                            관람등급: \(viewModel.detailInformation.audits)
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
                VStack(alignment: .leading) {
                    Image(uiImage: poster)
                        .resizable()
                        .aspectRatio(1.4, contentMode: .fit)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                    MovieInformationView(movieDetail: viewModel.detailInformation, boxOfficeMovie: boxOfficeMovie)
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
                        Text(boxOfficeMovie.rank + "위")
                            .bold()
                    }
                    HStack {
                        Text("전일 대비:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        if Int(boxOfficeMovie.rankIncrease) == 0 {
                            Rectangle()
                                .frame(width: 13, height: 2)
                        } else if Int(boxOfficeMovie.rankIncrease) ?? 0 > 0 {
                            HStack(spacing: 2) {
                                Text("↑")
                                    .foregroundColor(.red)
                                    .bold()
                                Text(boxOfficeMovie.rankIncrease)
                            }
                        } else {
                            HStack(spacing: 2) {
                                Text("↓")
                                    .foregroundColor(.blue)
                                    .bold()
                                Text(boxOfficeMovie.rankIncrease)
                            }
                        }
                    }
                    HStack {
                        Text("순위 진입 여부")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text(boxOfficeMovie.isNewRanked)
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
                        Text(viewModel.detailInformation.productionYear)
                            .bold()
                    }
                    HStack {
                        Text("개봉 연도:")
                            .foregroundColor(.gray)
                            .shadow(radius: 0.2)
                        Text(viewModel.detailInformation.productionYear)
                            .bold()
                    }
                }
            }
        }
        .frame(alignment: .center)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("❮" + " \(boxOfficeMovie.movieName)", action: {
            presentationMode.wrappedValue.dismiss()
        }))
        .onAppear {
            viewModel.fetchMovieDetail(movieCode: boxOfficeMovie.movieCode)
        }
    }
}

struct MovieInformationView: View {
    var movieDetail: MovieDetail
    var boxOfficeMovie: BoxOfficeMovie

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("영화명:")
                    .bold()
                Text(boxOfficeMovie.movieName)
                    .bold()
            }
            .font(.title3)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("개봉일:")
                    .bold()
                Text(boxOfficeMovie.openDate)
            }
            HStack {
                Text("관객수:")
                    .bold()
                Text(boxOfficeMovie.audienceAttendance.numberOfPeople + "명")
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("장르:")
                    .bold()
                HStack {
                    ForEach(movieDetail.genres, id: \.self) { genre in
                        Text(genre.genreName)
                    }
                }
            }
            HStack {
                Text("관람등급:")
                    .bold()
                if movieDetail.audits.isEmpty {
                    Text("")
                } else {
                    Text(movieDetail.audits[0].watchGradeName)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                Text("상영시간:")
                    .bold()
                Text(movieDetail.showTime + "분")
            }
            HStack {
                Text("감독:")
                    .bold()
                ForEach(movieDetail.directors, id: \.self) { director in
                    Text(director.peopleName)
                }
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}
