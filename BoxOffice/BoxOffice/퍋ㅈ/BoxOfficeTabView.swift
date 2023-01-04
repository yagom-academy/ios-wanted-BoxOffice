//
//  BoxOfficeTabView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI

struct BoxOfficeTabView: View {
    
    @StateObject private var imageLoader = URLImageLoader()
    
    var viewModel: BoxOfficeListViewModel
    var myIndex: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
            }
            Text("\(myIndex + 1)")
                .padding(10)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onAppear {
            imageLoader.fetch(urlString: viewModel.url[myIndex])
        }

    }
}

struct BoxOfficeTabView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeTabView(
            viewModel: BoxOfficeListViewModel(),
            myIndex: 0
        )
    }
}
