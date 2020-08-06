//
//  Goal+CoreDataProperties.swift
//  FocusOn
//
//  Created by Gabriel Balta on 21/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//
//

import Foundation
import CoreData

class Goal: NSManagedObject, Identifiable {
    
    override public func willChangeValue(forKey key: String) {
        super.willChangeValue(forKey: key)
        self.objectWillChange.send()
    }
    
    // Properties
    @NSManaged var goalID: UUID
    @NSManaged var title: String
    @NSManaged var complete: Bool 
    @NSManaged var createdAt: Date
    @NSManaged var month: String
    
    // Relationship
    @NSManaged var tasks: NSMutableSet
}


// MARK: Generated accessors for tasks
extension Goal {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        NSFetchRequest<Goal>(entityName: "Goal")
    }
    
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)
    
    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)
    
    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)
    
    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)
    
}
