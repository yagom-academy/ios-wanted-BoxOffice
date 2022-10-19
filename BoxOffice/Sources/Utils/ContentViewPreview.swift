//
//  Util.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import SwiftUI

#if canImport(SwiftUI) && DEBUG
struct ContentViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> some UIView {
        view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ContentViewControllerPreview<View: UIViewController>: UIViewControllerRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
#endif
