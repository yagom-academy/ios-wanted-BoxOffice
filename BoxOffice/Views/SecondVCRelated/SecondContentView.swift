//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

struct ReviewButtonView: View {
    
    @Binding var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "pencil.line")
                .resizable(resizingMode: .stretch)
                .frame(width: 40, height: 40)
        }.padding()
    }
}

struct ButtonView: View {
    
    @Binding var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "square.and.arrow.up")
                .resizable(resizingMode: .stretch)
                .frame(width: 40, height: 40, alignment: .center)
        }.padding()

    }
}

struct BasicDataView: View {
    
    @Binding var data: (title: String, data: String)
    
    var body: some View {
        VStack {
            Text(data.title)
                .font(.largeTitle)
                .padding(.all)
            Text(data.data)
                .font(.body)
                .padding(.all)
        }.multilineTextAlignment(.center)
        
    }
}

struct ArrayDataView: View {
    @Binding var data: (title: String, data: [String])
    
    var body: some View {
        VStack {
            Text(data.title)
                .font(.largeTitle)
                .padding(.all)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(data.data, id: \.self) { value in
                        Text(value)
                    }.font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.all)
                }
            }
        }
        
    }
}

struct SecondContentView: View {
    
    //SwiftUI View는 변경점이 생기면 뷰를 새로 만들었다가 없앴다가 새로 만들었다가 한다
    //그 과정에서 모델도 새로 만들어지고 없어졌다가 새로 만들어지고 한다.
    //그렇기에 모델은 한번 초기화가 되면 삭제-생성이 반복되는 것이 아닌 한번 만들어지면 그대로 메모리에 유지되도록 해야 한다. 그래서 @ObservedObject가 아니라 @StateObject를 붙여주는 것이다
    //StateObject는 ObservedObject와 거의 똑같으나, 하나의 객체로 만들어진다. 그리고 View가 얼마나 초기화되든지 상관없이 별개의 객체로 관리된다.
    @StateObject var viewModel: SecondContentViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                //$sign을 observedObject에 붙인다는건 그 안에 있는 @published 오브젝트를. binding 오브젝트로 꺼내서 쓰고, 서브뷰에 전파할 수 있게 해준다는 의미인 듯 하다
                BasicDataView(data: $viewModel.boxOfficeRank)
                    .padding()
                BasicDataView(data: $viewModel.movieName)
                    .padding()
                BasicDataView(data: $viewModel.releasedDay)
                    .padding()
                BasicDataView(data: $viewModel.audCount)
                    .padding()
                BasicDataView(data: $viewModel.rankIncrement)
                    .padding()
                BasicDataView(data: $viewModel.rankApproached)
                    .padding()
                BasicDataView(data: $viewModel.makedYear)
                    .padding()
                BasicDataView(data: $viewModel.releasedYear)
                    .padding()
                BasicDataView(data: $viewModel.runningTime)
                    .padding()
            }
            
            VStack {
                ArrayDataView(data: $viewModel.genre)
                    .padding()
                ArrayDataView(data: $viewModel.director)
                    .padding()
                ArrayDataView(data: $viewModel.actors)
                    .padding()
                ArrayDataView(data: $viewModel.restictionRate)
                    .padding()
                ButtonView(action: $viewModel.didTapShareButton)
                    .padding()
                ReviewButtonView(action: $viewModel.didTapReviewButton)
                    .padding()
            }
        }
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(viewModel: SecondContentViewModel())
    }
}
