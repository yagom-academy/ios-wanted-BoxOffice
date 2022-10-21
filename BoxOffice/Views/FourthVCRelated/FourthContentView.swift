//
//  FourthContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import SwiftUI

struct FourthContentView: View {
    
    @State private var date = Date()
    
    var body: some View {
        DatePicker("날짜 선택", selection: $date, displayedComponents: [.date])
            .datePickerStyle(.graphical)
    }
}

struct FourthContentView_Previews: PreviewProvider {
    static var previews: some View {
        FourthContentView()
    }
}
