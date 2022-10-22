//
//  Firebase+Combine.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import FirebaseStorage
import Combine

extension StorageReference {
    func getData(maxSize: Int64) -> Future<Data, Error> {
        return Future { promise in
            self.getData(maxSize: maxSize, completion: { promise($0) })
        }
    }
    
    func putData(_ uploadData: Data) -> Future<StorageMetadata, Error> {
        return Future { promise in
            self.putData(uploadData, completion: { promise($0) })
        }
    }
}
