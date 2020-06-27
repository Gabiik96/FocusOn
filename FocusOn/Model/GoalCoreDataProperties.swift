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
    
    // Properties
    @NSManaged var goalID: UUID
    @NSManaged var title: String
    @NSManaged var complete: Bool
    @NSManaged var createdAt: Date
    
    // Relationship
    @NSManaged var tasks: NSMutableSet?
}


// MARK: Generated accessors for tasks
extension Goal {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
