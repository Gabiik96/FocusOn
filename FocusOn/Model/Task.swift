//
//  Task.swift
//  FocusOn
//
//  Created by Gabriel Balta on 10/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

public class Task: NSManagedObject, Identifiable {
    static var entityName: String { return "Task" }
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var complete: Bool
}


