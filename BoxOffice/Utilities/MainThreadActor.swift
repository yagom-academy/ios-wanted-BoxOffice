//
//  MainThreadActor.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation
import SwiftUI

//해당 프로퍼티 어트리뷰트가 추가된 넘들은 메인스레드에서 구동될 것을 보장케 하고자 추가
//사실 애플이 이미 @MainActor를 만들었긴 하나 본 기능수정, 버그픽스 사항에서 도입하기엔 너무 큰 건인것 같다.
@propertyWrapper
struct MainThreadActor<T> {
    var closure: ((T) -> ())?
    
    var wrappedValue: ((T) -> ())? {
        get {
            return { value in
                DispatchQueue.main.async {
                    closure?(value)
                }
            }
        }
        
        set {
            closure = newValue
        }
    }
}
