//
//  ReviewListView.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/21.
//

import SwiftUI

struct CommentListView: View {
    
    @ObservedObject var commentManager: CommentManager
    @State private var newComment = ""
    
    var body: some View {
        VStack {
            List {
                
                ForEach(commentManager.comments) { comment in
                    CommentView(commentManager: commentManager, comment: comment)
                }
//                .listRowBackground(ColorManager.background)
            }
            .listStyle(.plain)
        }
//        .background(ColorManager.background)
    }
    
    func addComment(_ comment: Comment) {
        DispatchQueue.main.async {
            commentManager.update(comment)
        }
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView(commentManager: CommentManager.shared)
            .background(ColorManager.background)
    }
}
