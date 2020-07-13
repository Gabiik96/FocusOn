//
//  Task+CoreDataProperties.swift
//  FocusOn
//
//  Created by Gabriel Balta on 21/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//
//

import Foundation
import CoreData

class Task: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        NSFetchRequest<Task>(entityName: "Task")
    }
    
    // Properties
    @NSManaged var taskID: UUID
    @NSManaged var title: String
    @NSManaged var complete: Bool
    
    // Relationships
    @NSManaged var goal: Goal
}


