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
    
    var body: some View {
        TextField("타이틀", text: .constant("텍스트"))
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
            TextFieldView()
                .frame(minHeight: 40)
            TextFieldView()
                .frame(minHeight: 60)
            StarRateView()
                .frame(minHeight: 80)
            TextFieldView()
                .frame(minHeight: 40)
        }.padding()
    }
}

struct ThirdContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdContentView(viewModel: ThirdContentViewModel())
    }
}
