//
//  BoxOfficeReviewModel.swift
//  BoxOffice
//
//  Created by brad on 2023/01/06.
//

import Foundation
import SwiftUI

protocol BoxOfficeReviewModelProtocol {
    
    func fetchReviewData()
    func uploadReviewData()
}

final class BoxOfficeReviewModel: ObservableObject, BoxOfficeReviewModelProtocol {

    @Published var rating = 0
    @Published var nickname = ""
    @Published var password = ""
    @Published var description = ""
    
    @Published var imageArray = [UIImage]()
    
    func fetchReviewData() { }
    
    func uploadReviewData() { }
    
}
