//
//  ToDoItem.swift
//  FocusOn
//
//  Created by Gabriel Balta on 09/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

public class Goal: NSManagedObject, Identifiable {
    static var entityName: String { return "Goal" }
    
    //Attributes
    @NSManaged public var id: UUID
    @NSManaged public var createdAt: Date
    @NSManaged public var title: String
    @NSManaged public var complete: Bool
    
    //Relationship
    @NSManaged public var tasks: NSMutableSet?
}

