//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

struct SecondContentView: View {
    
    @ObservedObject var viewModel: SecondContentViewModel
    
    init(viewModel: SecondContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            
        }
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(viewModel: SecondContentViewModel())
    }
}
