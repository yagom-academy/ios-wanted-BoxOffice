//
//  MovieReview.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/18.
//

import Foundation
import FirebaseFirestoreSwift

struct MovieReview: Codable {

    // MARK: Properties

    @DocumentID var uuidString: String?

    /// 영화코드
    let movieIdentifier: String
    /// 별명
    let username: String
    /// 암호
    let password: String
    /// 별점
    let rating: Int
    /// 내용
    let content: String?
    /// 사진
    var image: URL?

    private let uuid: UUID

    // MARK: Init

    init(
        movieIdentifier: String,
        username: String,
        password: String,
        rating: Int,
        content: String? = nil,
        image: URL? = nil,
        uuid: UUID = UUID()
    ) {
        self.uuidString = uuid.uuidString
        self.movieIdentifier = movieIdentifier
        self.username = username
        self.password = password
        self.rating = rating
        self.content = content
        self.image = image
        self.uuid = uuid
    }

}

extension MovieReview: Hashable {

    static func == (lhs: MovieReview, rhs: MovieReview) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

}
