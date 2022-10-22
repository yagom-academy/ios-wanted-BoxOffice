//
//  CommentWriteView.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/22.
//

import SwiftUI

struct CommentWriteView: View {

    @ObservedObject var commentManager: CommentManager
    @State private var newComment: String = ""
    @State private var nickname: String = ""
    @State private var image = UIImage(systemName: "person.circle.fill")!
//        @State private var image = Image(systemName: "person.circle.fill")
    @State private var showSheet = false
    
    var body: some View {
        ColorManager.background
            .overlay(
                VStack {
                    VStack {
                        // FIXME: UIImage Tint 문제.
                        // Image로 하면 잘 적용되는데 UIImage는 다른 방식이 필요함.
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 90, height: 90, alignment: .leading)
                            .clipShape(Circle())
                            .foregroundColor(ColorManager.subText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            .onTapGesture {
                                showSheet = true
                            }
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)

                            }
                        VStack {
                            Spacer()
                            TextField("별명", text: $nickname)
                            Spacer()
                            HStack {
                                TextField("리뷰 내용을 작성해주세요.", text: $newComment)
                                Button("작성") {
                                    let comment = Comment(id: UUID(), profile: image, name: nickname, content: newComment)
                                    addComment(comment)
                                }
                                .foregroundColor(ColorManager.foregroud)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(20)
                }
                .scaledToFit()
                .background(ColorManager.cover)
                .cornerRadius(12)
                .padding(20)
            )
    }
    
    func addComment(_ comment: Comment) {
        DispatchQueue.main.async {
            commentManager.update(comment)
            print(commentManager.comments.count)
        }
    }
}

struct CommentWriteView_Previews: PreviewProvider {
    static var previews: some View {
        CommentWriteView(commentManager: CommentManager.shared)
            .previewLayout(.fixed(width: 350, height: 200))
            .scaledToFit()
    }
}
