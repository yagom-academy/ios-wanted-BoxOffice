//
//  ThirdContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import SwiftUI

struct PhotoView: View {
    var body: some View {
        Image("")
            .frame(width: 50, height: 50, alignment: .center)
    }
}

struct TextFieldView: View {
    
    @Binding var viewTitle: String
    @Binding var textInput: String
    
    var body: some View {
        HStack {
            Text(viewTitle)
            TextField("타이틀", text: $textInput)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)
        }
        
    }
}

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}

struct StarRateView: View {
    var body: some View {
        Text("스타레이트")
    }
}

struct ThirdContentView: View {
    
    @StateObject var viewModel: ThirdContentViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            PhotoView()
            TextFieldView(viewTitle: .constant("닉네임"), textInput: $viewModel.nickName)
                .frame(minHeight: 40)
            TextFieldView(viewTitle: .constant("암호"), textInput: $viewModel.passcode)
                .frame(minHeight: 60)
            StarRateView()
                .frame(minHeight: 80)
            TextFieldView(viewTitle: .constant("리뷰내용"), textInput: $viewModel.reviewContent)
                .frame(minHeight: 40)
        }.padding()
    }
}

struct ThirdContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdContentView(viewModel: ThirdContentViewModel())
    }
}
