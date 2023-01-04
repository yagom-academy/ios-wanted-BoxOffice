//
//  BoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI

struct BoxOfficeDetailView: View {
    
    @StateObject private var imageLoader = URLImageLoader()

    var viewModel: BoxOfficeListViewModel
    var myIndex: Int

    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 500, trailing: 0))
                    .blur(radius: 2, opaque: true)
            }
            HStack(alignment: .top) {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 200)
                        .frame(width: 150, height: 500)
                }
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 300)
                    Text("장르")
                    Text("개봉날짜")
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
        }
        
        .ignoresSafeArea()
        .onAppear {
            imageLoader.fetch(urlString: viewModel.url[myIndex])
        }
    }
}

struct BoxOfficeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BoxOfficeDetailView(
            viewModel: BoxOfficeListViewModel(),
            myIndex: 0
        )
    }
}
