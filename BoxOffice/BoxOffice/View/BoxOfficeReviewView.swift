//
//  BoxOfficeReviewView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/06.
//

import SwiftUI

struct BoxOfficeReviewView: View {
    private enum ActiveAlert {
        case first, second
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingImagePicker = false
    @State private var isNewAccountTapped = false
    @State private var isCheckPasswordEmpty = false
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first

    @ObservedObject var boxOfficeReviewModel = BoxOfficeReviewModel()
    
    var movieTitle: String
    
    var body: some View {
        ScrollView {
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
        }
        .navigationTitle(movieTitle)
        .toolbar {
            ToolbarItem {
                Button {
                    if boxOfficeReviewModel.password.validatePassword() {
                        boxOfficeReviewModel.uploadReviewData(getMoviewName: movieTitle)
                        activeAlert = .first
                    } else {
                        activeAlert = .second
                    }
                    showAlert.toggle()
                } label: {
                    Text("작성 완료")
                }
            }
        }
        .alert(isPresented: $showAlert) {
                    switch activeAlert {
                    case .first:
                        return Alert(title: Text("업로드 성공"), dismissButton: .default(Text("확인"), action: { dismiss() }))
                    case .second:
                        return Alert(title: Text("비밀번호 형식에 맞지 않습니다"), message: Text("-암호는 6자리 이상, 20자리 이하입니다.\n-암호는 알파벳 소문자와 아라비아 숫자, 특수문자(!, @, #, $의 4가지)만을 입력받습니다.\n-암호는 반드시 알파벳 소문자, 아라비아 숫자, 특수문자가 각 1개 이상 포함되어야 합니다."), dismissButton: .cancel())
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
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct BoxOfficeReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BoxOfficeReviewView(movieTitle: "영화 제목")
        }
    }
}
