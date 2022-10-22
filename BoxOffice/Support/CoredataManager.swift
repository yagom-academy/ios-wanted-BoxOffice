//
//  CoredataManager.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared: CoreDataManager = CoreDataManager()
    private let request = Review.fetchRequest()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Review")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetchReviews()-> [Review] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult
    func insertReviews(review: ReviewModel) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Review", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(review.nickname, forKey: "nickname")
            managedObject.setValue(review.password, forKey: "password")
            managedObject.setValue(review.starScore, forKey: "starScore")
            managedObject.setValue(review.content, forKey: "content")
            
            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    
    func count() -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }
}
