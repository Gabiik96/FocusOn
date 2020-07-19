//
//  DataController.swift
//  FocusOn
//
//  Created by Gabriel Balta on 17/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

class DataController {
    
    var goals = [Goal]()
    var timeController = TimeController()
    
    //MARK:- Add data
    
    func createEmptyGoalWithEmptyTasks(moc: NSManagedObjectContext) -> Goal {
        let todayGoal = Goal(context: moc)
        
        todayGoal.goalID = UUID()
        todayGoal.title = ""
        todayGoal.complete = false
        todayGoal.month = self.timeController.formattedMonthToString(date: Date())
        todayGoal.createdAt = self.timeController.today
        
        for _ in 1...3 {
            createEmptyTask(moc: moc, goal: todayGoal)
        }
        saveMoc(moc: moc)
        
        return todayGoal
    }
    
    func createEmptyTask(moc: NSManagedObjectContext, goal: Goal) {
        let emptyTask = Task(context: moc)
                    
        emptyTask.title = ""
        emptyTask.complete = false
        emptyTask.goal = goal
        
        saveMoc(moc: moc)
    }
    
    //MARK: - Update data
    
    func updateGoal(goal: Goal, newTitle: String? = nil, newDate: Date? = nil, completed: Bool? = nil, moc: NSManagedObjectContext) {
       
        if newTitle != nil { goal.title = newTitle! }
        if newDate != nil { goal.createdAt = newDate! }
        if let completed = completed { goal.complete = completed }
        
        saveMoc(moc: moc)
    }
    
    func updateTask(task: Task, newTitle: String? = nil, completed: Bool? = nil, moc: NSManagedObjectContext) {
        
        if newTitle != nil { task.title = newTitle! }
        if let completed = completed { task.complete = completed }
        
        saveMoc(moc: moc)
    }
    
    func saveMoc(moc: NSManagedObjectContext) {
        do {
            try moc.save()
        } catch {
            print("Failed to save MOC. \(error)")
            moc.rollback()
        }
    }

}
