//
//  FourthContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import Foundation

class FourthContentViewModel: ObservableObject {
    
    //input
    var didReceiveNewDate: (Date) -> () = { date in }
    
    //output
    var propergateNewDate: (String) -> () = { dateString in }

    //properties
    
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveNewDate = { [weak self] date in
            guard let self = self else { return }
            let dateString = date.asString(.koficFormat)
            print("date check : \(date)")
            print("dateString check : \(date)")
            self.propergateNewDate(dateString)
        }
    }
}
