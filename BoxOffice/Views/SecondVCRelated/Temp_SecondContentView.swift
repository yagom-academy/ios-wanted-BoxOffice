//
//  SecondContentView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import SwiftUI

struct Temp_SecondContentView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0x1f600...0x1f679, id: \.self) { value in
                    Text(String(format: "%x", value))
                    Text(emoji(value))
                        .font(.largeTitle)
                }
            }
        }
    }
    
    private func emoji(_ value: Int) -> String {
            guard let scalar = UnicodeScalar(value) else { return "?" }
            return String(Character(scalar))
        }
}

struct Temp_SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        Temp_SecondContentView()
    }
}
