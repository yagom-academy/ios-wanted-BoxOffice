//
//  MovieReviewPostView.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/03.
//

import SwiftUI
import PhotosUI

struct Review {
    let nickName: String
    let passWord: String
    let starRate: Int
    let review: String
    let picture: UIImage
}

struct MovieReviewPostView: View {
    @Binding var isPresented: Bool
    @State var selected = -1
    @State var nickName: String = ""
    @State var password: String = ""
    @State var reView: String = ""
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var profileImage = UIImage(systemName: "person.crop.circle")
    //    @Binding var reviews: [Review]

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isPresented = false
            } label: {
                HStack {
                    Text("X")
                }
            }
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
            Spacer()
            VStack {
                Text("이 영화 어땠나요?")
                    .font(.title3)
                    .foregroundColor(Color.black)
                HStack {
                    RatingView(selected: $selected)
                }
                HStack {
                    Text("나의 감상평")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color.black)
                        .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                }
                HStack {
                    TextField("  별명", text: $nickName)
                        .frame(height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2))
                    TextField("  암호", text: $password)
                        .frame(height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2))
                }
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                VStack(spacing: 0) {
                    ZStack(alignment: .topLeading) {
                        HStack {
                            Image(uiImage: profileImage ?? UIImage())
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 0))
                            Rectangle()
                                .frame(width: 2, height: 290)
                                .foregroundColor(Color.white)
                                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                            TextEditor(text: $reView)
                                .lineLimit(0)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 20))
                                .frame(height: 300)
                        }
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                            .frame(height: 300)
                    }
                    ZStack(alignment: .center) {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 2))
                                    .frame(height: 40)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            HStack {
                                Button {
                                    showImagePicker.toggle()
                                } label: {
                                    Image(systemName: "camera.fill")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                                .sheet(isPresented: $showImagePicker) {
                                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                    PhotoPicker(configuration: configuration, isPresented: $showImagePicker)
                                }
                                Spacer()
                                    Button {

                                    } label: {
                                        Text("등록")
                                            .frame(width: 50, height: 30)
                                            .foregroundColor(.white)
                                            .background(Color.blue)
                                            .cornerRadius(5)
                                    }
                            }
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                        }
                }
                Spacer()
            }
        }
    }
}

struct RatingView: View {
    @Binding var selected: Int

    var body: some View {
        ForEach(0..<5) { rating in
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(self.selected >= rating ? .yellow : .gray)
                .onTapGesture {
                    self.selected = rating
                }
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration

    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            parent.isPresented = false
        }
    }
}
