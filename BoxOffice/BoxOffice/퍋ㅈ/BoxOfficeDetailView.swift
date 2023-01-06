//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI

struct BoxOfficeDetailView: View {
    @StateObject var detailViewModel = MovieDetailViewModel()
    
    var viewModel: BoxOfficeMainViewModel
    var myIndex: Int
    
    var body: some View {
        ZStack {
            Image(uiImage: viewModel.url[myIndex])
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 550, trailing: 0))
                .blur(radius: 2, opaque: true)
            
            VStack {
                HStack(alignment: .top) {
                    Image(uiImage: viewModel.url[myIndex])
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 200)
                        .frame(width: 150, height: 500)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.movieList[myIndex].movieNm)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.top, 350)
                        Text("")
                        HStack {
                            Text(detailViewModel.currentPageMovieDetail?.nations[0].nationNm ?? "")
                            Text("/")
                            Text(detailViewModel.currentPageMovieDetail?.genreNm ?? "")
                        }
                        .foregroundColor(.primary)
                        .font(.caption)
                        HStack {
                            Text((detailViewModel.currentPageMovieDetail?.openDatDt ?? "").dateYearFormatter.translateToString2() + " 개봉")
                            Image(systemName: "clock.arrow.circlepath")
                            Text((detailViewModel.currentPageMovieDetail?.showTm ?? "") + " 분")
                        }
                        .foregroundColor(.primary)
                        .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                
                HStack(spacing: 40) {
                    VStack {
                        Button {
                            print("Review Button!!")
                        } label: {
                            Text("리뷰 작성")
                        }
                    }
                    VStack {
                        Text("랭킹 진입 여부")
                            .font(.system(size: 10))
                        Text(viewModel.movieList[myIndex].rankOldAndNew.rawValue)
                    }
                    VStack {
                        Text("누적 관객수")
                            .font(.system(size: 10))
                        Text(viewModel.movieList[myIndex].audiAcc.insertComma + " 명")
                    }
                }
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Rectangle()
                    .foregroundColor(Color.black)
                    .opacity(0.5)
                    .blur(radius: 2, opaque: true)
                )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            detailViewModel.fetchCurrentMovieDetail(movieBoxOfficeInfo: viewModel.movieList[myIndex])
        }
    }
}
