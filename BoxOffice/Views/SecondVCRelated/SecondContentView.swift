//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

struct BasicDataView: View {
    
    @Binding var title: String
    @Binding var data: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
            Text(data)
                .font(.body)
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
                
                HStack {
                    Text($viewModel.movieName.wrappedValue.title)
                    Text($viewModel.movieName.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.releasedDay.wrappedValue.title)
                    Text($viewModel.releasedDay.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.audCount.wrappedValue.title)
                    Text($viewModel.audCount.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.rankIncrement.wrappedValue.title)
                    Text($viewModel.rankIncrement.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.rankApproached.wrappedValue.title)
                    Text($viewModel.rankApproached.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.makedYear.wrappedValue.title)
                    Text($viewModel.makedYear.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.releasedYear.wrappedValue.title)
                    Text($viewModel.releasedYear.wrappedValue.data)
                }
                HStack {
                    Text($viewModel.runningTime.wrappedValue.title)
                    Text($viewModel.runningTime.wrappedValue.data)
                }
                
                //todo: 배열데이터에 대한 처리
            }
        }
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(viewModel: SecondContentViewModel())
    }
}
