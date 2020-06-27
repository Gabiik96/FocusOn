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

    var notCompletedYesterdayGoal = [Goal]()
    var goals = [Goal]()
    var delegate: DataControllerDelegate?
    var moc: NSManagedObjectContext
    var timeController = TimeController()

    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        moc = appDelegate.persistentContainer.viewContext
    }
    
//     MARK:- Add data
    
    func createEmptyGoalWithEmptyTasks() -> UUID {
        let todayGoal = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: self.moc) as! Goal
    
        todayGoal.goalID = UUID()
        todayGoal.title = ""
        todayGoal.complete = false
        todayGoal.createdAt = self.timeController.today
        delegate?.goals.append(todayGoal)
        
        createEmptyTask(goalID: todayGoal.goalID)
        
        return todayGoal.goalID
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
                    
                    emptyTask.id = UUID()
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
    
    func updateDeleteGoal(goalID: UUID, newTitle: String? = nil, newDate: Date? = nil, complete: Bool? = nil, delete: Bool = false) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Goal.goalID), goalID as CVarArg)
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if let returnedResult = result as? [Goal] {
                if returnedResult.count != 0 {
                    let fetchedGoal = returnedResult.first!
                    
                    if delete {
                        // Delete fetchedGoal with its current Tasks
                        self.moc.delete(fetchedGoal)
                    } else {
                        // Update new values for fetchedGoal
                        if newTitle != nil { fetchedGoal.title = newTitle! }
                        if newDate != nil { fetchedGoal.createdAt = newDate! }
                        if complete != nil { fetchedGoal.complete = complete! }
                    }
                    
                    do {
                        try self.moc.save() 
                    } catch {
                        print("Failed to save update on Goal. \(error)")
                        self.moc.rollback()
                    }
                } else { print("Fetch result failed, empty for Goal ID: \(goalID)") }
            }
        } catch { print("Failed to save MOC. \(error)") }
    }
    
    //MARK: - Data fetching
    
    func fetchGoals(date: Date) -> [Goal] {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "createdAt = %@", timeController.getDay(date: date) as NSDate)
        
        do {
            let goals = try self.moc.fetch(fetchRequest)
            return goals
        } catch {
            print("Failed to fetch goals by date. \(error)")
        }
        
        return [Goal]()
    }
    
    func fetchTodayGoal() {
        if goals.count == 0 {
            goals = fetchGoals(date: timeController.today)
            
            if goals.count == 0 {
                let yesterdayGoal = fetchGoals(date: timeController.yesterday)
                
                if yesterdayGoal.count != 0 {
                    
                    for goal in yesterdayGoal {
                        if goal.complete == false {
                            notCompletedYesterdayGoal.append(goal)
                        }
                    }
                }
            }
        }
    }
    
}
