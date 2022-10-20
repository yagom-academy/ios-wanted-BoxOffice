//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

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
    
    @ObservedObject var viewModel: SecondContentViewModel
    
    init(viewModel: SecondContentViewModel) {
        self.viewModel = viewModel
    }
    
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
            }
        }
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(viewModel: SecondContentViewModel())
    }
}
