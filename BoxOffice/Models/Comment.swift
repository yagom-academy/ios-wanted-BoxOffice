//
//  Comment.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/21.
//

import Foundation
import SwiftUI

protocol didUpdatedChildViewSizeProtocol {
    func didUpdateSize(_ size: CGSize)
}

class CommentManager: Identifiable, ObservableObject {
    
    var delegate: didUpdatedChildViewSizeProtocol?
    
    @Published var comments = [Comment]()
    static let shared = CommentManager()
    
    private init() { }
    
    func update(_ comment: Comment) {
        comments.append(comment)
        delegate?.didUpdateSize(CGSize(width: 10, height: 10))
    }
}

struct Comment: Identifiable {
    var id: UUID
    var profile: UIImage
    var name: String
    var content: String
    
    init(id: UUID, profile: UIImage, name: String, content: String) {
        self.id = id
        self.profile = profile
        self.name = name
        self.content = content
    }
}

extension Comment {
    static let sampleData: [Comment] =
    [
        Comment(id: UUID(), profile: UIImage(systemName: "person.circle.fill")!, name: "name", content: "comment"),
        Comment(id: UUID(), profile: UIImage(systemName: "person.circle.fill")!, name: "BlackSkirt9503", content: "저어어엉말 재밌는 영화에오."),
        Comment(id: UUID(), profile: UIImage(systemName: "person.circle.fill")!, name: "xXx", content: "리뷰입니다. 리뷰입니다. 리뷰입니다. 리뷰입니다. 리뷰입니다. 리뷰입니다. 리뷰입니다."),
        Comment(id: UUID(), profile: UIImage(systemName: "person.circle.fill")!, name: "상수역", content: "남녀를 구분하지 않고 냉정하게 스토리를 따라가면서 느낀건데 주인공 같은 자기만 아는 이기적인 존재를 곁에두고 싶지 않다.\n현시대의 사람은 10을주면 11을 받아야 호구가 아니라는 생각이  주를 이루다 보니 스스로의 만족만을 위해  타인에게 1의 희생을 원하다 (스스로는 10:10이라 생각하지만 제3자의 눈에는 대다수가 자신에게 기울어져있다)\n근데 헤어진 시한부 전남친에게 찾아가 그가 그렇게 원하던 임심을 다른사람과 했다고 고민 상담하는 짓은  여주가 소시오패스적 성향을 진하게 가졌다는 합리적 의심이 생김(상대에 대한 1%의 배려도 없는 짓) \n성별을 바꿔서도 생각해 보면   곁을 주기 힘든 부류의 사람이다."),
        Comment(id: UUID(), profile: UIImage(systemName: "person.circle.fill")!, name: "asklerjakljwocwaklcjklcsdf", content: "Good")
    ]
}
