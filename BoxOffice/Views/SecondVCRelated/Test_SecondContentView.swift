//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

struct Test_SecondContentView: View {
    
    //environment state 같은 걸로 해야할줄 알았는데 이렇게도 되긴 되나...
    @ObservedObject var viewModel: SecondContentViewModel
    
    init(viewModel: SecondContentViewModel) {
        self.viewModel = viewModel
    }
    
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
//                ForEach(viewModel.dataSource) { value in
//                    Text(value.name)
//                    Text(value.data)
//                }
            }
        }
    }
}

struct Test_SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        Test_SecondContentView(viewModel: SecondContentViewModel())
    }
}
