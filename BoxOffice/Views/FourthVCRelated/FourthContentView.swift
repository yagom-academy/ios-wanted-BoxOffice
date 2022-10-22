//
//  FourthContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import SwiftUI

struct FourthContentView: View {
    
    @StateObject var viewModel: FourthContentViewModel
    @State private var yesterday = Date().addingTimeInterval(TimeInterval(-86400))
    @State private var selectedDay = Date().addingTimeInterval(TimeInterval(-86400))
    
    var body: some View {
        DatePicker("날짜 선택", selection: $selectedDay, in: ...yesterday , displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .onChange(of: selectedDay) { newValue in
                self.viewModel.didReceiveNewDate(newValue)
            }
    }
}

struct FourthContentView_Previews: PreviewProvider {
    static var previews: some View {
        FourthContentView(viewModel: FourthContentViewModel())
    }
}
