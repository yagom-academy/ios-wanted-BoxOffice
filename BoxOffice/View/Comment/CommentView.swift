//
//  CommentView.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/21.
//

import SwiftUI

struct CommentView: View {
    
    @ObservedObject var commentManager: CommentManager
    @State var comment: Comment
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(uiImage: comment.profile)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .clipShape(Circle())
                        .padding(.top, 13)
                    Text(comment.name)
                        .font(Font.custom("NotoSansKR-Light", size: 13))
                        .allowsTightening(true)
                        .lineLimit(2)
                        .foregroundColor(ColorManager.foregroud)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                .frame(width: 60, alignment: .center)
                VStack {
                    Text(comment.content)
                        .font(Font.custom("NotoSansKR-Regular", size: 15))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background(ColorManager.cover)
                        .cornerRadius(14)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.75)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.vertical, 13)
            }
        }
//        .frame(maxWidth: .infinity)
        .font(Font.custom("NotoSansKR-Regular", size: 15))
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(commentManager: CommentManager.shared, comment: Comment.sampleData[0])
            .previewLayout(.fixed(width: 300, height: 100))
            .listRowInsets(EdgeInsets())
            .scaledToFit()
    }
}
