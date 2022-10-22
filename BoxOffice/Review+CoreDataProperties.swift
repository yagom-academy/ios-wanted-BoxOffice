//
//  Review+CoreDataProperties.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/22.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var password: String?
    @NSManaged public var nickname: String?
    @NSManaged public var starScore: Int16
    @NSManaged public var content: String?
    @NSManaged public var movieID: String?

}

extension Review : Identifiable {

}
