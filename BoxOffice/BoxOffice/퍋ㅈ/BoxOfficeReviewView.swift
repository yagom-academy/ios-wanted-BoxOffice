//
//  BoxOfficeReviewView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/06.
//

import SwiftUI

struct BoxOfficeReviewView: View {
    @State private var showingImagePicker = false
    @State private var isNewAccountTapped = false
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    
    @StateObject var boxOfficeReviewModel = BoxOfficeReviewModel(movieNm: "Avatar: The Way of Water")
    
    var movieTitle: String
    
    var body: some View {
        VStack {
            ZStack {
                starsView.overlay(overlayView.mask(starsView))
            }
            .frame(height: 200)
            TextField("별명", text: $boxOfficeReviewModel.nickname)
                .padding(10)
                .foregroundColor(.secondary)
                .background(
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(Color.secondary)
                )
            SecureField("암호", text: $boxOfficeReviewModel.password)
                .padding(10)
                .foregroundColor(.secondary)
                .background(
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(Color.secondary)
                )
            ZStack {
                TextEditor(text: $boxOfficeReviewModel.description)
                    .frame(minHeight: 200, maxHeight: .infinity)
                    .cornerRadius(15)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .circular)
                            .stroke(Color.secondary)
                    )
                if boxOfficeReviewModel.description.isEmpty {
                    Text("리뷰를 작성해주세요")
                        .foregroundColor(Color.secondary)
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                }
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<boxOfficeReviewModel.imageArray.count, id: \.self) { images in
                        Image(uiImage: boxOfficeReviewModel.imageArray[images])
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    if boxOfficeReviewModel.imageArray.count < 5 {
                        Button {
                            self.showingImagePicker.toggle()
                        } label: {
                            Image(systemName: "camera")
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color.white)
                                .background(Color.secondary)
                            
                        }.sheet(isPresented: $showingImagePicker) {
                            ImagePicker(sourceType: .photoLibrary) { (image) in
                                boxOfficeReviewModel.imageArray.append(image)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle(movieTitle)
        .toolbar {
            ToolbarItem {
                Button {
                    boxOfficeReviewModel.uploadReviewData()
                } label: {
                    Text("작성 완료")
                }
            }
        }
    }
    private var overlayView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(boxOfficeReviewModel.rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { star in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            boxOfficeReviewModel.rating = star
                            UserDefaults.standard.setValue(boxOfficeReviewModel.rating, forKey: "rating_key")
                        }
                    }
            }
        }
    }
}

struct BoxOfficeReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BoxOfficeReviewView(movieTitle: "영화 제목")
        }
    }
}
