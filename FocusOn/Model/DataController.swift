//
//  DataController.swift
//  FocusOn
//
//  Created by Gabriel Balta on 17/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

protocol DataControllerDelegate {
    var goals: [Goal] { get set }
}

class DataController {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    var goals = [Goal]()
    var delegate: DataControllerDelegate?
    var timeController = TimeController()
    
//    init() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        moc = appDelegate.persistentContainer.viewContext
//    }
    
    //     MARK:- Add data
    
    func createEmptyGoalWithEmptyTasks(moc: NSManagedObjectContext) -> Goal {
        let todayGoal = Goal(context: moc)
        
        todayGoal.goalID = UUID()
        todayGoal.title = ""
        todayGoal.complete = false
        todayGoal.month = self.timeController.formattedMonthToString(date: Date())
        todayGoal.createdAt = self.timeController.today
        delegate?.goals.append(todayGoal)
        
        for _ in 1...3 {
            createEmptyTask(goalID: todayGoal.goalID)
        }
        
        do {
                   try moc.save()
               } catch {
                   print("Failed to save MOC. \(error)")
                   moc.rollback()
               }
        
        return todayGoal
    }
    
    func createEmptyTask(goalID: UUID) {
        let emptyTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: self.moc) as! Task
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Goal.goalID), goalID as CVarArg)
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if let returnedResult = result as? [Goal] {
                if returnedResult.count != 0 {
                    let fetchedGoal = returnedResult.first!
                    
                    emptyTask.title = ""
                    emptyTask.complete = false
                    emptyTask.goal = fetchedGoal
                } else { print("Fetch result failed, empty for Goal ID: \(goalID)") }
            }
        } catch { print("Fetch failed, Goal ID: \(goalID) error: \(error)")}
        
        do {
            try moc.save()
        } catch {
            print("Failed to save MOC. \(error)")
            moc.rollback()
        }
    }
    
    
    
    //MARK: - Update data / Delete data
    
    func updateDeleteGoal(goalID: UUID, newTitle: String? = nil, newDate: Date? = nil, complete: Bool? = nil, delete: Bool = false, moc: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Goal.goalID), goalID as CVarArg)
        
        do {
            let result = try moc.fetch(fetchRequest)
            if let returnedResult = result as? [Goal] {
                if returnedResult.count != 0 {
                    let fetchedGoal = returnedResult.first!
                    
                    if delete {
                        // Delete fetchedGoal with its current Tasks
                        moc.delete(fetchedGoal)
                    } else {
                        // Update new values for fetchedGoal
                        if newTitle != nil { fetchedGoal.title = newTitle! }
                        if newDate != nil { fetchedGoal.createdAt = newDate! }
                        if complete != nil { fetchedGoal.complete = complete! }
                    }
                    
                    do {
                        try moc.save()
                    } catch {
                        print("Failed to save update on Goal. \(error)")
                        moc.rollback()
                    }
                } else { print("Fetch result failed, empty for Goal ID: \(goalID)") }
            }
        } catch { print("Failed to save MOC. \(error)") }
    }
    
    func updateOrDeleteTask(taskID: UUID, goalID: UUID, newTitle: String? = nil, completed: Bool? = nil, delete: Bool = false) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Task")
        let withGoalIDPredicate = NSPredicate(format: "%K == %@", #keyPath(Task.goal.goalID), "\(goalID)")
        let findTaskPredicate = NSPredicate(format: "%K == %@", #keyPath(Task.taskID), "\(taskID)")
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [withGoalIDPredicate, findTaskPredicate])
        
        do {
            let result = try moc.fetch(fetchRequest)
            if let returnedResult = result as? [Task] {
                if returnedResult.count != 0 {
                    let fetchedTask = returnedResult.first!
                    
                    if delete {
                        // Delete goal (This also deletes all corosponding tasks!)
                        moc.delete(fetchedTask)
                    } else {
                        // Set new values for goal if not nill.
                        if let newTitle = newTitle { fetchedTask.title = newTitle }
                        if let completed = completed { fetchedTask.complete = completed }
                    }
                    
                    do {
                        try moc.save()
                    } catch {
                        print("Save failed: \(error)")
                        moc.rollback()
                    }
                } else {
                    print("Fetch result was empty for specified task id: \(taskID), goal id: \(goalID).")
                }
            }
        } catch {
            print("Fetch on task id: \(taskID), goal id: \(goalID) failed. \(error)")
        }
    }
    
    
    //MARK: - Data fetching
    
    
    //    func filterDataByMonth(data: [Goal]) {
    //        let filteredData = data.filter { (dat) -> Bool in
    //            let
    //        }
    
    //    }
    
    
}
